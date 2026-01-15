package com.utmserenityhub.service;

import com.utmserenityhub.dao.AssessmentDAO;
import com.utmserenityhub.model.AssessmentType;
import com.utmserenityhub.model.AssessmentQuestion;
import com.utmserenityhub.model.AssessmentResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AssessmentService {

    @Autowired
    private AssessmentDAO assessmentDAO;

    /* get all assessment types */
    public List<AssessmentType> getAllAssessmentTypes() {
        return assessmentDAO.findAllTypes();
    }

    /**
     * Create new assessment type
     */
    public int createAssessmentType(AssessmentType assessmentType) {
        return assessmentDAO.createAssessmentType(assessmentType);
    }

    /**
     * Toggle assessment type active status
     */
    public boolean toggleAssessmentTypeStatus(int typeId) {
        return assessmentDAO.toggleAssessmentTypeStatus(typeId);
    }

    /**
     * Update assessment type
     */
    public boolean updateAssessmentType(AssessmentType assessmentType) {
        return assessmentDAO.updateAssessmentType(assessmentType);
    }

    /* get active assessment types */
    public List<AssessmentType> getActiveAssessmentTypes() {
        return assessmentDAO.findActiveTypes();
    }

    /* get assessment type by ID */
    public AssessmentType getAssessmentTypeById(int typeId) {
        return assessmentDAO.findTypeById(typeId);
    }

    /* get assessment questions */
    public List<AssessmentQuestion> getAssessmentQuestions(int assessmentTypeId) {
        return assessmentDAO.findQuestionsByTypeId(assessmentTypeId);
    }

    /* get questions by category */
    public List<AssessmentQuestion> getQuestionsByCategory(int assessmentTypeId, String category) {
        return assessmentDAO.findQuestionsByCategory(assessmentTypeId, category);
    }

    /* create assessment question */
    public int createQuestion(AssessmentQuestion question) {
        return assessmentDAO.createQuestion(question);
    }

    /* update assessment question */
    public boolean updateQuestion(AssessmentQuestion question) {
        return assessmentDAO.updateQuestion(question);
    }

    /* delete assessment question */
    public boolean deleteQuestion(int questionId) {
        return assessmentDAO.deleteQuestion(questionId);
    }

    /* get question by ID */
    public AssessmentQuestion getQuestionById(int questionId) {
        return assessmentDAO.findQuestionById(questionId);
    }

    /**
     * Process and save assessment results
     * For DASS-21 assessment
     */
    public AssessmentResult processAssessment(int studentId, int assessmentTypeId, Map<String, String> answers) {
        // get questions to determine categories
        List<AssessmentQuestion> questions = assessmentDAO.findQuestionsByTypeId(assessmentTypeId);

        // calculate scores for each category
        int depressionScore = 0;
        int anxietyScore = 0;
        int stressScore = 0;

        for (AssessmentQuestion question : questions) {
            String answerKey = "q_" + question.getAssessmentQuestionId();
            String answerValue = answers.get(answerKey);

            if (answerValue != null) {
                int score = Integer.parseInt(answerValue);

                // categorize scores based on question category
                switch (question.getCategory().toUpperCase()) {
                    case "DEPRESSION":
                        depressionScore += score;
                        break;
                    case "ANXIETY":
                        anxietyScore += score;
                        break;
                    case "STRESS":
                        stressScore += score;
                        break;
                }
            }
        }

        // multiply by 2 for DASS-21
        depressionScore *= 2;
        anxietyScore *= 2;
        stressScore *= 2;

        // determine overall severity (based on highest score)
        AssessmentResult.Severity severity = determineSeverity(depressionScore, anxietyScore, stressScore);

        // generate recommendations
        String recommendations = generateRecommendations(depressionScore, anxietyScore, stressScore, severity);

        // create result object
        AssessmentResult result = new AssessmentResult();
        result.setStudentId(studentId);
        result.setAssessmentTypeId(assessmentTypeId);
        result.setDepressionScore(depressionScore);
        result.setAnxietyScore(anxietyScore);
        result.setStressScore(stressScore);
        result.setOverallSeverity(severity);
        result.setRecommendations(recommendations);

        // save to database
        int resultId = assessmentDAO.createResult(result);
        result.setResultId(resultId);

        return result;
    }

    /* Determine severity based on scores */
    private AssessmentResult.Severity determineSeverity(int depressionScore, int anxietyScore, int stressScore) {
        // get the highest score among all three
        int maxScore = Math.max(depressionScore, Math.max(anxietyScore, stressScore));

        // DASS-21 severity ranges
        if (maxScore <= 9) {
            return AssessmentResult.Severity.NORMAL;
        } else if (maxScore <= 13) {
            return AssessmentResult.Severity.MILD;
        } else if (maxScore <= 20) {
            return AssessmentResult.Severity.MODERATE;
        } else if (maxScore <= 27) {
            return AssessmentResult.Severity.SEVERE;
        } else {
            return AssessmentResult.Severity.EXTREMELY_SEVERE;
        }
    }

    /* Generate recommendations based on scores */
    private String generateRecommendations(int depressionScore, int anxietyScore,
            int stressScore, AssessmentResult.Severity severity) {
        StringBuilder recommendations = new StringBuilder();

        recommendations.append("Based on your assessment results:\n\n");

        // depression recommendations
        if (depressionScore > 9) {
            recommendations.append("Depression: Your score indicates ")
                    .append(getSeverityLevel(depressionScore, "depression"))
                    .append(" depression. ");
            if (depressionScore > 20) {
                recommendations.append("We strongly recommend seeking professional help. ");
            }
            recommendations.append("\n\n");
        }

        // anxiety recommendations
        if (anxietyScore > 7) {
            recommendations.append("Anxiety: Your score indicates ")
                    .append(getSeverityLevel(anxietyScore, "anxiety"))
                    .append(" anxiety. ");
            if (anxietyScore > 14) {
                recommendations.append("Consider speaking with a counselor. ");
            }
            recommendations.append("\n\n");
        }

        // stress recommendations
        if (stressScore > 14) {
            recommendations.append("Stress: Your score indicates ")
                    .append(getSeverityLevel(stressScore, "stress"))
                    .append(" stress levels. ");
            if (stressScore > 25) {
                recommendations.append("Please prioritize self-care and stress management. ");
            }
            recommendations.append("\n\n");
        }

        // general recommendations
        recommendations.append("General Recommendations:\n");
        recommendations.append("• Consider booking an appointment with our counselors\n");
        recommendations.append("• Explore our learning modules on mental health\n");
        recommendations.append("• Practice self-care and stress management techniques\n");
        recommendations.append("• Connect with peers in our support forum\n");

        if (severity == AssessmentResult.Severity.SEVERE ||
                severity == AssessmentResult.Severity.EXTREMELY_SEVERE) {
            recommendations.append("\nIMPORTANT: Your scores suggest you may benefit from professional support. ")
                    .append("Please book an appointment with our counselors or contact student support services.");
        }

        return recommendations.toString();
    }

    /* get severity level description */
    private String getSeverityLevel(int score, String type) {
        if (type.equals("depression")) {
            if (score <= 9)
                return "normal";
            else if (score <= 13)
                return "mild";
            else if (score <= 20)
                return "moderate";
            else if (score <= 27)
                return "severe";
            else
                return "extremely severe";
        } else if (type.equals("anxiety")) {
            if (score <= 7)
                return "normal";
            else if (score <= 9)
                return "mild";
            else if (score <= 14)
                return "moderate";
            else if (score <= 19)
                return "severe";
            else
                return "extremely severe";
        } else { // stress
            if (score <= 14)
                return "normal";
            else if (score <= 18)
                return "mild";
            else if (score <= 25)
                return "moderate";
            else if (score <= 33)
                return "severe";
            else
                return "extremely severe";
        }
    }

    /* get result by ID */
    public AssessmentResult getResultById(int resultId) {
        return assessmentDAO.findResultById(resultId);
    }

    /* get student's assessment history */
    public List<AssessmentResult> getStudentAssessmentHistory(int studentId) {
        return assessmentDAO.findResultsByStudentId(studentId);
    }

    /* get recent results for student */
    public List<AssessmentResult> getRecentResults(int studentId, int limit) {
        return assessmentDAO.findRecentResultsByStudentId(studentId, limit);
    }

    /* get all assessment results */
    public List<AssessmentResult> getAllResults() {
        return assessmentDAO.findAllResults();
    }

    /* get results by severity */
    public List<AssessmentResult> getResultsBySeverity(AssessmentResult.Severity severity) {
        return assessmentDAO.findResultsBySeverity(severity);
    }

    /* count assessments completed by student */
    public int countStudentAssessments(int studentId) {
        return assessmentDAO.countByStudentId(studentId);
    }

    /* count all assessment results */
    public int countAllResults() {
        return assessmentDAO.countAllResults();
    }

    /* get latest result for student */
    public AssessmentResult getLatestResult(int studentId, int assessmentTypeId) {
        return assessmentDAO.findLatestResult(studentId, assessmentTypeId);
    }

    /* get assessment statistics */
    public AssessmentStatistics getStatistics() {
        AssessmentStatistics stats = new AssessmentStatistics();

        stats.setTotalAssessments(assessmentDAO.countAllResults());
        stats.setNormalCount(assessmentDAO.findResultsBySeverity(AssessmentResult.Severity.NORMAL).size());
        stats.setMildCount(assessmentDAO.findResultsBySeverity(AssessmentResult.Severity.MILD).size());
        stats.setModerateCount(assessmentDAO.findResultsBySeverity(AssessmentResult.Severity.MODERATE).size());
        stats.setSevereCount(assessmentDAO.findResultsBySeverity(AssessmentResult.Severity.SEVERE).size());
        stats.setExtremelySevereCount(
                assessmentDAO.findResultsBySeverity(AssessmentResult.Severity.EXTREMELY_SEVERE).size());

        return stats;
    }

    // Inner class for statistics
    public static class AssessmentStatistics {
        private int totalAssessments;
        private int normalCount;
        private int mildCount;
        private int moderateCount;
        private int severeCount;
        private int extremelySevereCount;

        // Getters and Setters
        public int getTotalAssessments() {
            return totalAssessments;
        }

        public void setTotalAssessments(int totalAssessments) {
            this.totalAssessments = totalAssessments;
        }

        public int getNormalCount() {
            return normalCount;
        }

        public void setNormalCount(int normalCount) {
            this.normalCount = normalCount;
        }

        public int getMildCount() {
            return mildCount;
        }

        public void setMildCount(int mildCount) {
            this.mildCount = mildCount;
        }

        public int getModerateCount() {
            return moderateCount;
        }

        public void setModerateCount(int moderateCount) {
            this.moderateCount = moderateCount;
        }

        public int getSevereCount() {
            return severeCount;
        }

        public void setSevereCount(int severeCount) {
            this.severeCount = severeCount;
        }

        public int getExtremelySevereCount() {
            return extremelySevereCount;
        }

        public void setExtremelySevereCount(int extremelySevereCount) {
            this.extremelySevereCount = extremelySevereCount;
        }
    }
}