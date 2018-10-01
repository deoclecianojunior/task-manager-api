require 'rails_helper'

RSpec.describe 'Task API', type: :request do
	before { host! 'api.task-manager.test' }

	let!(:user) { create(:user) }
	let(:headers) do
		{
			'Accept' => 'application/vnd.taskmanager.vi',
			'Content-Type' => Mime[:json].to_s,
			'Authorization' => user.auth_token
		}
	end

	describe 'GET /tasks' do
		before do 
			create_list(:task, 5, user_id: user.id)
			get '/tasks', params: {}, headers: headers
		end

		it 'returns 5 tasks from database' do
			expect(json_body[:tasks].count).to eq(5)
		end
	end
end