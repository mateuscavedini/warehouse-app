require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir do menu' do
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'

    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'E-mail'
  end

  it 'com sucesso' do
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'CNPJ', with: '47176140000189'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 47176140000189'
    expect(page).to have_content 'Endereço: Av das Palmas, 100'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'com dados incompletos' do
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não cadastrado.'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end