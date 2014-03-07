require 'spec_helper'

feature Ticket do
  feature "when a user is logged in" do
   
    before do
      create_and_sign_in("arash@ouji.com",'aaaaaaaa')
      create(:ticket,title:"height")

    end

    scenario "can view all tickets" do
      create(:ticket,title:"might")
      create(:ticket,title:"right")
      visit "/"
      click_link "Tickets"
      expect(page.body).to match(/height.*might.*right/im)
    end

    scenario "can resolve an unresolved ticket" do
      visit "/"
      click_on "Mark #{Ticket.first.id} Resolved"
      expect(page).to have_button("Mark #{Ticket.first.id} un-Resolved")
    end

    scenario "can un-resolve a resolved ticket" do
      u = create (:user)
      ticket = create(:ticket,title:"height",resolved: true,resolver_id: u.id)
      visit "/"
      click_on "Mark #{ticket.id} un-Resolved"
      expect(page).to have_button("Mark #{ticket.id} Resolved")
    end

    scenario "can toggle between resolved and unresoled" do
      visit "/"
      click_on "Mark #{Ticket.first.id} Resolved"
      click_on "Mark #{Ticket.first.id} un-Resolved"
      expect(page).to have_button("Mark #{Ticket.first.id} Resolved")
    end

    # scenario "can view any ticket's page" do
    #   create(:ticket,title:"height",body:"is high")
    #   visit "/"
    #   click_on "height"
    #   expect(page).to have_text("is high")
    # end

    scenario "can post valid tickets" do
      visit "/"
      click_on "Post Ticket"
      fill_in "Title", with: "help me :("
      fill_in "Body", with: "I need to know what a computer is"
      click_on "submit ticket"
      expect(page).to have_text("You did it man, I don't know how, but YOU DID IT")
    end

    scenario "cannot post invalid tickets" do
      visit "/"
      click_on "Post Ticket"
      fill_in "Body", with: "I need to know what a computer is"
      click_on "submit ticket"
      expect(page).to have_text("Keep your spirits high and try again")
    end

  end

end