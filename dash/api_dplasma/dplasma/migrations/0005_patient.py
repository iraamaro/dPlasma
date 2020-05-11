# Generated by Django 3.0.6 on 2020-05-11 02:13

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('dplasma', '0004_doctor'),
    ]

    operations = [
        migrations.CreateModel(
            name='Patient',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('ethereum_address', models.CharField(max_length=255)),
                ('city', models.CharField(max_length=255)),
                ('blood_type', models.CharField(max_length=3)),
                ('ind', models.CharField(max_length=1)),
                ('three_box_profile', models.CharField(max_length=255)),
                ('hospital_id', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='hospital_id', to='dplasma.Hospital')),
            ],
            options={
                'db_table': 'patient',
            },
        ),
    ]