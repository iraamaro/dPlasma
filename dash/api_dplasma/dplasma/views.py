from django.shortcuts import render

# Create your views here.

from rest_framework import generics
from .models import Hospital, Doctor, Patient, Hematologist, Donor
from .serializers import HospitalSerializer, DoctorSerializer, PatientSerializer, HematologistSerializer, DonorSerializer

# Create your views here.
class HospitalList(generics.ListCreateAPIView):
    queryset = Hospital.objects.all()
    serializer_class = HospitalSerializer

class DoctorList(generics.ListCreateAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer

class PatientList(generics.ListCreateAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer

class HematologistList(generics.ListCreateAPIView):
    queryset = Hematologist.objects.all()
    serializer_class = HematologistSerializer

class DonorList(generics.ListCreateAPIView):
    queryset = Donor.objects.all()
    serializer_class = DonorSerializer