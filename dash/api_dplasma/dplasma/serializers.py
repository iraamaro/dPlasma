from rest_framework import serializers
from .models import Hospital, Doctor, Patient, Hematologist, Donor

class HospitalSerializer(serializers.ModelSerializer):

    class Meta:

        model = Hospital
        fields = '__all__'


class DoctorSerializer(serializers.ModelSerializer):
    category_name = serializers.ReadOnlyField(source='category.name')

    class Meta:

        model = Doctor
        fields = '__all__'

class PatientSerializer(serializers.ModelSerializer):
    category_name = serializers.ReadOnlyField(source='category.name')

    class Meta:

        model = Patient
        fields = '__all__'

class HematologistSerializer(serializers.ModelSerializer):
    category_name = serializers.ReadOnlyField(source='category.name')

    class Meta:

        model = Hematologist
        fields = '__all__'

class DonorSerializer(serializers.ModelSerializer):
    category_name = serializers.ReadOnlyField(source='category.name')

    class Meta:

        model = Donor
        fields = '__all__'