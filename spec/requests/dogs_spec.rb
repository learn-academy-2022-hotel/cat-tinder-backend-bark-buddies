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
      it "creates a dog and recieve the proper response" do
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
      it "doesn't create a dog without a name" do
      dog_params = {
        dog: {
          age: 3,
          enjoys: 'Dog food and sunshine.',
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        }
      }
      post '/dogs', params: dog_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end
      it "doesn't create a dog without an age" do
        dog_params = {
          dog: {
            name: "Billy",  
            enjoys: 'Dog food and sunshine.',
            image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
        }
      }
      post '/dogs', params: dog_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response['age']).to include "can't be blank"
    end
    it "doesn't create a dog without an enjoys" do
      dog_params = {
        dog: {
          name: "Billy",  
          age: 5,
          image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
      }
    }
    post '/dogs', params: dog_params
    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)
    expect(json_response['enjoys']).to include "can't be blank"
    end
    it 'cannot create a dog without an image' do
      dog_params = {
        dog: {
          name: "Billy",  
          age: 5,
          enjoys: 'Dog food and sunshine.'
      }
    }
    post '/dogs', params: dog_params
    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)
    expect(json_response['image']).to include "can't be blank"
  end
  it 'cannot create a dog unless enjoys is at least 10 characters long' do
      dog_params = {
        dog: {
          name: "Billy",  
          age: 5,
          enjoys: 'food',
         image: 'https://images.unsplash.com/photo-1654994983327-d0f6fcde017b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
    }
  }
    post '/dogs', params: dog_params
    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)
    expect(json_response['enjoys']).to include "is too short (minimum is 10 characters)"
  end
end
    describe "PATCH /update" do
      it "updates a dog at a particular ID" do
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