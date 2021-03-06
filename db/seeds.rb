require_relative( "../models/animal.rb" )
require_relative( "../models/vet.rb" )
require_relative( "../models/owner.rb" )
require_relative( "../models/checking.rb" )
require_relative( "../models/treatment.rb" )
require_relative( "../models/appointment.rb" )
require("pry-byebug")

Vet.delete_all()
Animal.delete_all()
Owner.delete_all()
Checking.delete_all()
Treatment.delete_all()
Appointment.delete_all()

vet1 = Vet.new('first_name' => "James", 'last_name' => "Sullivan")
vet1.save()

vet2 = Vet.new('first_name' => "Elon", 'last_name' => "Musk")
vet2.save()

vet3 = Vet.new('first_name' => "Marilyn", 'last_name' => "Munroe")
vet3.save()

owner1 = Owner.new('first_name' => 'James', 'last_name' => 'Khan',
                    'address' => '123 Rd, G1 3ED', 'tel_no' => '0141 123456',
                    'registered' => true)
owner1.save()

owner2 = Owner.new('first_name' => 'Theresa', 'last_name' => 'May',
                    'address' => '1 Posh Place, L1 1AA', 'tel_no' => '0141 000000',
                    'registered' => true)
owner2.save()

owner3 = Owner.new('first_name' => 'Greta', 'last_name' => 'Thurnberg',
                    'address' => '1 A road, GG1 1AA', 'tel_no' => '01 66 000000',
                    'registered' => true)
owner3.save()

animal1 = Animal.new('name' => "Raja", 'type' => "cat", 'dob' => "01-01-18",
               'owner_id' => owner1.id, 'treatment_notes' => "Suffering from cat flu",
               'vet_id' => vet1.id)
animal1.save()

animal2 = Animal.new('name' => "Rocko", 'type' => "doggo", 'dob' => "03-06-16",
               'owner_id' => owner2.id, 'treatment_notes' => "Broken Leg",
               'vet_id' => vet2.id)
animal2.save()

animal2 = Animal.new('name' => "Buster", 'type' => "Rabbit", 'dob' => "03-06-00",
               'owner_id' => owner2.id, 'treatment_notes' => "Drinking problem",
               'vet_id' => vet3.id)
animal2.save()

animal2 = Animal.new('name' => "Big bird", 'type' => "Bird", 'dob' => "03-07-00",
               'owner_id' => owner2.id, 'treatment_notes' => "Drinking problem",
               'vet_id' => vet3.id)
animal2.save()

checking1 = Checking.new('check_in' => '01/04/20', 'check_out' => '02-04-20',
                         'id' => animal1.id)
checking1.save()

checking2 = Checking.new('check_in' => '02/04/20', 'check_out' => '06-04-20',
                         'id' => animal2.id)
checking2.save()

treatment1 = Treatment.new('details' => 'some words', 'bill' => 100,
                            'animal_id' => animal1.id,  'tr_date'=> "03-04-2020", 'paid' => false)
treatment1.save()
treatment2 = Treatment.new('details' => 'some words', 'bill' => 100,
                            'animal_id' => animal1.id, 'tr_date'=> "03-04-2020", 'paid' => false)
treatment2.save()

# treatment3 = Treatment.new('details' => 'some words', 'bill' => 100,
#                             'animal_id' => animal2.id, 'tr_date'=> "18-02-2019")
# treatment3.save()

treatment4 = Treatment.new('details' => 'some words', 'bill' => 100,
                            'animal_id' => animal2.id, 'tr_date'=> '01-03-2020', 'paid' => true)
treatment4.save()

appointment1 = Appointment.new('app_date'=> '04/04/2020/', 'app_time'=>'07:00',
                                'animal_id'=> animal1.id , 'vet_id' => vet1.id,
                                'notes' => 'To be seen about sore eyes')
appointment1.save()

appointment2 = Appointment.new('app_date'=> '04/14/2020', 'app_time'=>'09:00',
                                'animal_id'=> animal2.id , 'vet_id' => vet3.id,
                                'notes' => 'Chronic silliness')
appointment2.save()

appointment3 = Appointment.new('app_date'=> '04/14/2020', 'app_time'=>'10:00',
                                'animal_id'=> animal2.id , 'vet_id' => vet3.id,
                                'notes' => 'Chronic silliness')
appointment3.save()

binding.pry
nil
