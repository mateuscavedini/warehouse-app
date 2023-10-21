require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar'

    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field 'Razão Social', with: 'ACME LTDA'
    expect(page).to have_field 'Nome Fantasia', with: 'ACME'
    expect(page).to have_field 'CNPJ', with: '47176140000189'
    expect(page).to have_field 'Endereço', with: 'Av das Palmas, 100'
    expect(page).to have_field 'Cidade', with: 'Bauru'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'E-mail', with: 'contato@acme.com'
  end

  it 'com sucesso' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'CNPJ', with: '40475540000719'
    fill_in 'Endereço', with: 'Av das Palmeiras, 100'
    fill_in 'E-mail', with: 'vendas@acme.com.br'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso!'
    expect(page).to have_content 'Fornecedor ACME'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 40475540000719'
    expect(page).to have_content 'Endereço: Av das Palmeiras, 100'
    expect(page).to have_content 'E-mail: vendas@acme.com.br'
  end

  it 'e mantém os campos obrigatórios' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o fornecedor.'
  end
end