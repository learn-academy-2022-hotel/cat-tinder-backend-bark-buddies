# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



it "can't update a dog at a particular ID unless a name is present" do
        Dog.create(
          name: 'Buster',
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        )

        dog_params = {
          dog: {
            name: nil,
            age: 4,
            enjoys: 'Dog food and sunshine.',
            image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
          }
        }
        dog = Dog.last
        patch "/dogs/#{dog.id}", params: dog_params
        updated_dog = Dog.find(dog.id).update(dog_params)
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to include "can't be blank"
      end
      it "can't update a dog at a particular ID unless age is present" do
        Dog.create(
          name: 'Buster',
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        )

        dog_params = {
          dog: {
            name: 'Buster',
            age: nil,
            enjoys: 'Dog food and sunshine.',
            image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
          }
        }
        dog = Dog.last
        patch "/dogs/#{dog.id}", params: dog_params
        updated_dog = Dog.find(dog.id)
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['age']).to include "can't be blank"
      end
      it "can't update a dog at a particular ID unless enjoys is present" do
        Dog.create(
          name: 'Buster',
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        )

        dog_params = {
          dog: {
            name: 'Buster',
            age: 3,
            enjoys: nil,
            image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
          }
        }
        dog = Dog.last
        patch "/dogs/#{dog.id}", params: dog_params
        updated_dog = Dog.find(dog.id)
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['enjoys']).to include "can't be blank"
      end
      it "can't update a dog at a particular ID unless an image is present" do
        Dog.create(
          name: 'Buster',
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        )

        dog_params = {
          dog: {
            name: 'Buster',
            age: 3,
            enjoys: 'Dog food and sunshine.',
            image: nil
          }
        }
        dog = Dog.last
        patch "/dogs/#{dog.id}", params: dog_params
        updated_dog = Dog.find(dog.id)
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['image']).to include "can't be blank"
      end