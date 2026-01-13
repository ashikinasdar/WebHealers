package com.utmserenityhub.service;

import com.utmserenityhub.dao.LearningModuleDAO;
import com.utmserenityhub.model.LearningModule;
import com.utmserenityhub.model.ModuleProgress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class LearningModuleService {
    
    @Autowired
    private LearningModuleDAO moduleDAO;
    
    /*Create a new learning module*/
    public int createModule(LearningModule module) {
        return moduleDAO.create(module);
    }

    /*Get module by ID*/
    public LearningModule getModuleById(int moduleId) {
        return moduleDAO.findById(moduleId);
    }

    /*Update module*/
    public boolean updateModule(LearningModule module) {
        return moduleDAO.update(module);
    }

    /*Delete module*/
    public boolean deleteModule(int moduleId) {
        return moduleDAO.delete(moduleId);
    }

    /*Activate module*/
    public boolean activateModule(int moduleId) {
        return moduleDAO.setActive(moduleId, true);
    }

    /*Deactivate module*/
    public boolean deactivateModule(int moduleId) {
        return moduleDAO.setActive(moduleId, false);
    }

    /*Get all modules*/
    public List<LearningModule> getAllModules() {
        return moduleDAO.findAll();
    }

    /*Get active modules*/
    public List<LearningModule> getActiveModules() {
        return moduleDAO.findActive();
    }

    /*Get modules by category*/
    public List<LearningModule> getModulesByCategory(String category) {
        return moduleDAO.findByCategory(category);
    }

    /*Get active modules count*/
    public int getActiveModulesCount() {
        return moduleDAO.countActive();
    }

    /*Search modules*/
    public List<LearningModule> searchModules(String keyword) {
        return moduleDAO.search(keyword);
    }

    /*Validate module data*/
    public boolean validateModule(LearningModule module) {
        if (module == null) {
            return false;
        }
        
        if (module.getTitle() == null || module.getTitle().trim().isEmpty()) {
            return false;
        }
        
        if (module.getContent() == null || module.getContent().trim().isEmpty()) {
            return false;
        }
        
        if (module.getDurationMinutes() < 0) {
            return false;
        }
        
        return true;
    }

    /*Create or update progress*/
    public boolean createProgress(ModuleProgress progress) {
        int result = moduleDAO.createProgress(progress);
        return result > 0;
    }

    /*Update student's progress for a module*/
    public boolean updateProgress(int studentId, int moduleId, double progressPercentage) {
        // Ensure progress is within valid range
        if (progressPercentage < 0) {
            progressPercentage = 0;
        } else if (progressPercentage > 100) {
            progressPercentage = 100;
        }
        
        return moduleDAO.updateProgress(studentId, moduleId, progressPercentage);
    }

    /*Get or create progress record*/
    public ModuleProgress getOrCreateProgress(int studentId, int moduleId) {
        ModuleProgress progress = moduleDAO.findProgress(studentId, moduleId);
        
        if (progress == null) {
            // Create new progress record
            progress = new ModuleProgress(studentId, moduleId);
            moduleDAO.createProgress(progress);
            // Fetch the created record
            progress = moduleDAO.findProgress(studentId, moduleId);
        }
        
        return progress;
    }

    /*Get student's progress for a module*/
    public ModuleProgress getProgress(int studentId, int moduleId) {
        return moduleDAO.findProgress(studentId, moduleId);
    }

    /*Get all progress for a student*/
    public List<ModuleProgress> getStudentProgress(int studentId) {
        return moduleDAO.findProgressByStudentId(studentId);
    }

    /*Get modules with progress for student*/
    public List<Map<String, Object>> getModulesWithProgress(int studentId) {
        return moduleDAO.findModulesWithProgress(studentId);
    }

    /*Get completed modules count for student*/
    public int getCompletedModulesCount(int studentId) {
        return moduleDAO.countCompletedByStudentId(studentId);
    }

    /*Calculate overall learning progress percentage*/
    public double calculateOverallProgress(int studentId) {
        List<ModuleProgress> progressList = moduleDAO.findProgressByStudentId(studentId);
        int totalActiveModules = moduleDAO.countActive();
        
        if (totalActiveModules == 0) {
            return 0.0;
        }
        
        double totalProgress = 0.0;
        for (ModuleProgress progress : progressList) {
            totalProgress += progress.getProgressPercentage();
        }
        
        return totalProgress / totalActiveModules;
    }

    /*Mark module as completed*/
    public boolean completeModule(int studentId, int moduleId) {
        return updateProgress(studentId, moduleId, 100.0);
    }

    /*Get learning statistics for student*/
    public LearningStatistics getStudentStatistics(int studentId) {
        LearningStatistics stats = new LearningStatistics();
        
        int totalModules = moduleDAO.countActive();
        int completedModules = moduleDAO.countCompletedByStudentId(studentId);
        List<ModuleProgress> progressList = moduleDAO.findProgressByStudentId(studentId);
        
        int inProgressCount = (int) progressList.stream()
            .filter(p -> p.getStatus() == ModuleProgress.Status.IN_PROGRESS)
            .count();
        
        stats.setTotalModules(totalModules);
        stats.setCompletedModules(completedModules);
        stats.setInProgressModules(inProgressCount);
        stats.setNotStartedModules(totalModules - completedModules - inProgressCount);
        stats.setOverallProgress(calculateOverallProgress(studentId));
        
        return stats;
    }
    
    // Inner class for learning statistics
    public static class LearningStatistics {
        private int totalModules;
        private int completedModules;
        private int inProgressModules;
        private int notStartedModules;
        private double overallProgress;
        
        // Getters and Setters
        public int getTotalModules() {
            return totalModules;
        }
        
        public void setTotalModules(int totalModules) {
            this.totalModules = totalModules;
        }
        
        public int getCompletedModules() {
            return completedModules;
        }
        
        public void setCompletedModules(int completedModules) {
            this.completedModules = completedModules;
        }
        
        public int getInProgressModules() {
            return inProgressModules;
        }
        
        public void setInProgressModules(int inProgressModules) {
            this.inProgressModules = inProgressModules;
        }
        
        public int getNotStartedModules() {
            return notStartedModules;
        }
        
        public void setNotStartedModules(int notStartedModules) {
            this.notStartedModules = notStartedModules;
        }
        
        public double getOverallProgress() {
            return overallProgress;
        }
        
        public void setOverallProgress(double overallProgress) {
            this.overallProgress = overallProgress;
        }
    }
}
