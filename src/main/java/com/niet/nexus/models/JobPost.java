package com.niet.nexus.models;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Job_Posts")
public class JobPost {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "alumni_id", nullable = false)
    private User alumni;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String description;

    private String company;
    private String location;

    @Column(name = "is_referral_available", columnDefinition = "boolean default false")
    private Boolean isReferralAvailable = false;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", insertable = false, updatable = false)
    private Date createdAt;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getAlumni() { return alumni; }
    public void setAlumni(User alumni) { this.alumni = alumni; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Boolean getIsReferralAvailable() { return isReferralAvailable; }
    public void setIsReferralAvailable(Boolean isReferralAvailable) { this.isReferralAvailable = isReferralAvailable; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
