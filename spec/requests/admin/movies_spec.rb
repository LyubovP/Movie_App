require 'rails_helper'

RSpec.describe "Admin::Movies", type: :request do
  subject { get '/movies' }
  it(:status) { should eq 200 }

  let(:user) { User.create!(email: 'admin@example.com', password: 'password', admin: 'true') }
  let(:movie) { Movie.create!(title: 'bluhbluhbluh', description: 'bluhbluhbluh',category: 'Fantasy') }

  before(:each) do
    sign_in user
  end

  describe 'edit' do
    it 'renders movie' do
      get "/admin/movies/#{movie.title}/edit"
      expect(assigns(:movie)).to eq movie
    end
  end

  describe 'update' do
    it 'updates movie' do
      patch "/admin/categories/#{movie.title}", params: {
        id: movie, movie: {
          title: 'new-title',
          description: 'Description'
        }
      }

      movie.reload
      expect(movie.title).to eq 'new-title'
      expect(movie.description).to eq 'Description'
    end
  end
end
