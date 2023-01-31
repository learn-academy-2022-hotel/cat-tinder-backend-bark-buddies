class DogsController < ApplicationController

    def index
        dogs = Dog.all
        render json: dogs
    end
      
    def create
        dog = Dog.create(dog_params)
        render json: dog
    end
      
    def update
        dog = Dog.find(params[:id])
        Dog.update(dog_params)
        render json: dog
    end
      
    def destroy
        dog = Dog.find(params[:id])
        if dog.destroy 
        render json: dog    
        end
    end
      
    private
    def dog_params
    params.require(:dog).permit(:name, :age, :enjoys, :image)
    end
end
