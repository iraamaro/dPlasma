# Generated by Django 3.0.6 on 2020-05-10 23:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dplasma', '0002_hospital_three_box_profile'),
    ]

    operations = [
        migrations.AlterField(
            model_name='hospital',
            name='three_box_profile',
            field=models.CharField(max_length=255),
        ),
    ]