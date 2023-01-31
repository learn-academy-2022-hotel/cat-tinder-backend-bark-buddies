
dogs = [
  {
    name: 'Felix',
    age: 2,
    enjoys: 'Long naps on the couch, and a warm fire.',
    image: ''
  },
  {
    name: 'Homer',
    age: 12,
    enjoys: 'Food mostly, really just food.',
    image: ''
  },
  {
    name: 'Santi',
    age: 5,
    enjoys: 'Longs walks on the beach.',
    image: ''
  }
]

dogs.each do |each_dog|
  Dog.create each_dog
  puts "creating dog #{each_dog}"
end