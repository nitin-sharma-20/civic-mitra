from django.urls import path
from .views import IssueReportCreateView, IssueReportListView

urlpatterns = [
    path('issues/create/', IssueReportCreateView.as_view(), name='issue-create'),
    path('issues/', IssueReportListView.as_view(), name='issue-list'),
]
