package com.niet.nexus.models;

import jakarta.persistence.*;

@Entity
@Table(name = "Profiles")
public class Profile {
    @Id
    @Column(name = "user_id")
    private Long userId;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "user_id")
    private User user;

    private String department;
    
    @Column(name = "graduation_year")
    private Integer graduationYear;

    @Column(name = "current_industry")
    private String currentIndustry;

    private String company;
    
    @Column(name = "job_title")
    private String jobTitle;

    @Column(columnDefinition = "TEXT")
    private String skills;

    @Column(name = "willingness_to_refer", columnDefinition = "boolean default false")
    private Boolean willingnessToRefer = false;

    @Column(name = "mentorship_points", columnDefinition = "int default 0")
    private Integer mentorshipPoints = 0;

    // Getters and Setters
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public Integer getGraduationYear() { return graduationYear; }
    public void setGraduationYear(Integer graduationYear) { this.graduationYear = graduationYear; }
    public String getCurrentIndustry() { return currentIndustry; }
    public void setCurrentIndustry(String currentIndustry) { this.currentIndustry = currentIndustry; }
    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }
    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    public Boolean getWillingnessToRefer() { return willingnessToRefer; }
    public void setWillingnessToRefer(Boolean willingnessToRefer) { this.willingnessToRefer = willingnessToRefer; }
    public Integer getMentorshipPoints() { return mentorshipPoints; }
    public void setMentorshipPoints(Integer mentorshipPoints) { this.mentorshipPoints = mentorshipPoints; }
}
