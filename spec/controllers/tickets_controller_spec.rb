require 'spec_helper'

describe TicketsController do
  describe "with a signed in user" do
    
    before do
      @u1 = create :user
      sign_in @u1
    end

    describe "get :index" do
      
      before do
        create :ticket
        create :ticket
        create :ticket
        get :index
      end

      it "responds with success" do
        expect(response).to be_success
      end

      it "returns all tickets" do
        expect(assigns(:tickets).length).to eq(3)
      end

    end

    # describe "get :show" do
      
    #   before do
    #     create :ticket
    #     get :show
    #   end

    #   it "responds with success" do
    #     expect(response).to be_success
    #   end

    #   it "returns all tickets" do
    #     expect(assigns(:tickets).length).to eq(3)
    #   end

    # end

    describe "get :new" do

      before do
        get :new
      end

      it "creates an empty ticket" do
        expect(assigns(:ticket)).to be
      end

    end

    describe "post :create" do

      describe "with valid params" do
        
        let(:valid_params) do 
          {ticket:{title: "Oh snap",body: "I'm askin why?",resolved: true}}
        end

        before do
          post :create, valid_params
        end

        it "creates a ticket and saves it" do
          expect(assigns(:ticket).persisted?).to eq(true)
        end

        it "creates a ticket with the params" do
          expect(assigns(:ticket).title).to eq("Oh snap")
          expect(assigns(:ticket).body).to eq("I'm askin why?")
          expect(assigns(:ticket).resolved).to eq(true)
        end

      end

      describe "with invalid params" do
        let(:invalid_params) do 
          {ticket:{title: "",body: "",resolved: true}}
        end

        before do
          post :create, invalid_params
        end

        it "does not save the invalid ticket" do
          expect(assigns(:ticket)).to be_invalid
        end

      end

    end

    describe "patch :update" do
      let(:ticket) {create(:ticket,resolved: false)}

      let(:valid_params) do {id: ticket.id,
          ticket:{resolved: true}
          }
      end
      
      it "should not work if user is not authenticated" do
        sign_out @u1
        patch :update, valid_params
        expect(assigns(:ticket)).to eq(nil)
      end

      it "should work if user is authenticated" do
        patch :update, valid_params
        expect(assigns(:ticket).resolved).to eq(true)
      end

      it "should set correct resolver when resolving" do
        patch :update, valid_params
        expect(assigns(:ticket).resolver).to eq(@u1)
      end

      it "should set correct resolver when resolving" do
        patch :update, valid_params
        unresolve_params={id: ticket.id,
                          ticket:{resolved: false}}
        patch :update, unresolve_params
        expect(assigns(:ticket).resolver).to eq(nil)
      end
    end
  end
end