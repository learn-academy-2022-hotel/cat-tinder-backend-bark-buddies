require 'rails_helper'

RSpec.describe "Dogs", type: :request do
    describe "GET /index" do
        it "gets a list of dogs" do
            Dog.create(
              name: 'Homer',
              age: 12,
              enjoys: 'Food mostly, really just food.',
              image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
            )

            get '/dogs'

            dog = JSON.parse(response.body)
            expect(response).to have_http_status(200)
            expect(dog.length).to eq 1
        end
    end
    describe "POST /create" do
      it "creates a dog" do
        dog_params = {
          dog: {
            name: 'Buster',
            age: 3,
            enjoys: 'Dog food and sunshine.',
            image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
          }
        }

        post '/dogs', params: dog_params

        expect(response).to have_http_status(200)
        dog = Dog.first
        expect(dog.name).to eq 'Buster'
      end
    end
    describe "PATCH /update" do
      it "updates a dog" do
        Dog.create(
          name: 'Buster',
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        )

        dog_params = {
          dog: {
            name: 'Buster',
            age: 4,
            enjoys: 'Dog food and sunshine.',
            image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
          }
        }
        dog = Dog.last
        patch "/dogs/#{dog.id}", params: dog_params
        updated_dog = Dog.find(dog.id)
        expect(response).to have_http_status(200)
        expect(updated_dog.age).to eq(4)
      end
    end

    describe "DELETE /destroy" do
      it "deletes a dog profile" do
        Dog.create(
          name: 'Buster',
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        )

        dog = Dog.last
        delete "/dogs/#{dog.id}"
        expect(response).to have_http_status(200)
        expect(Dog.all).to be_empty
      end
    end
end