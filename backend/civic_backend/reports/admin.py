from django.contrib import admin
from .models import IssueReport

@admin.register(IssueReport)
class IssueReportAdmin(admin.ModelAdmin):
    list_display = ('id','user','category','status','created_at')
    list_filter = ('category','status','created_at')
    search_fields = ('description','user__username')
