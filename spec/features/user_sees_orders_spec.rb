require 'rails_helper'

describe 'user sees statistics on orders' do
  describe 'registered user clicks on orders' do
    it 'takes the user to their orders page' do
      user_1 = User.create(name: 'Sherlock Holmes', address: '221 Baker street', city: 'London', state: 'oppressed',
      zip_code: '12345', email: 'AwesomeSauce@gmail.com', password: '123123')


    end
  end
end
