from rest_framework import generics
from .models import IssueReport
from .serializers import IssueReportSerializer

class IssueReportCreateView(generics.CreateAPIView):
    queryset = IssueReport.objects.all()
    serializer_class = IssueReportSerializer

class IssueReportListView(generics.ListAPIView):
    queryset = IssueReport.objects.all().order_by('-created_at')
    serializer_class = IssueReportSerializer
