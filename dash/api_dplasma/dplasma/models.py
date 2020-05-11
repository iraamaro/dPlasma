from django.db import models

# Create your models here.

class Hospital(models.Model):

    class Meta:

        db_table = 'hospital'

    address = models.CharField(max_length=255)
    hospital_name = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    ethereum_address = models.CharField(max_length=255)
    three_box_profile = models.CharField(max_length=255)


    def __str__(self):
        return self.hospital_name
        
class Doctor(models.Model):

    class Meta:

        db_table = 'doctor'

    complete_name = models.CharField(max_length=255)
    license = models.CharField(max_length=255)
    hospital = models.ForeignKey('Hospital', related_name='hospital', on_delete=models.DO_NOTHING)
    ethereum_address = models.CharField(max_length=255)
    three_box_profile = models.CharField(max_length=255)


    def __str__(self):
        return self.complete_name


class Patient(models.Model):

    class Meta:

        db_table = 'patient'

    ethereum_address = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    hospital_id = models.ForeignKey('Hospital', related_name='hospital_id', on_delete=models.DO_NOTHING)
    blood_type = models.CharField(max_length=3)
    ind = models.CharField(max_length=1)
    three_box_profile = models.CharField(max_length=255)


    def __str__(self):
        return self.ethereum_address

class Hematologist(models.Model):

    class Meta:

        db_table = 'hematologist'

    complete_name = models.CharField(max_length=255)
    license = models.CharField(max_length=255)
    hospital = models.ForeignKey('Hospital', related_name='hospital_identification', on_delete=models.DO_NOTHING)
    ethereum_address = models.CharField(max_length=255)
    three_box_profile = models.CharField(max_length=255)

    def __str__(self):
        return self.ethereum_address


class Donor(models.Model):

    class Meta:

        db_table = 'donor'

    ethereum_address = models.CharField(max_length=255, default="")
    city = models.CharField(max_length=255, default="New York")
    birth_date = models.DateField(auto_now=False)
    blood_type = models.CharField(max_length=3)  
    weight = models.PositiveSmallIntegerField(default=60)
    last_donation = models.DateField(auto_now=False)
    serological_test_result = models.CharField(max_length=1)
    date_of_first_symptom = models.DateField(auto_now=False)
    date_of_last_symptom = models.DateField(auto_now=False)
    pcr_result = models.CharField(max_length=1)
    gender = models.CharField(max_length=1)
    comorbidities_for_donation = models.CharField(max_length=1)
    last_tatoo = models.DateField(auto_now=False)
    hematologist_report_blob = models.CharField(max_length=255)
    hematologist_id = models.ForeignKey('Hematologist', related_name='hematologist_id', on_delete=models.DO_NOTHING)
    hospital_id = models.ForeignKey('Hospital', related_name='hospital_reg', on_delete=models.DO_NOTHING)
    three_box_profile = models.CharField(max_length=255)


    def __str__(self):
        return self.ethereum_address