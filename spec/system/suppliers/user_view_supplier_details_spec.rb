require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
  it 'a partir da tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'

    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 47176140000189'
    expect(page).to have_content 'Endereço: Av das Palmas, 100'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'e volta para a tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end