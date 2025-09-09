from django.db import models
from django.contrib.auth.models import User

class IssueReport(models.Model):
    CATEGORY_CHOICES = [
        ('pothole', 'Pothole'),
        ('garbage', 'Garbage'),
        ('streetlight', 'Streetlight'),
        ('other', 'Other'),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES, default='other')
    description = models.TextField()
    image = models.ImageField(upload_to='issue_images/')
    latitude = models.FloatField()
    longitude = models.FloatField()
    status = models.CharField(max_length=50, default='Submitted')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.category} by {self.user.username}"
