require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(name: 'Mateus Silva', email: 'mateus@email.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'E-mail', with: 'mateus@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Mateus Silva - mateus@email.com'
    end
  end

  it 'e faz logout' do
    User.create!(email: 'mateus@email.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'mateus@email.com'
    fill_in 'Senha', with: 'password'
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'mateus@email.com'
  end
end