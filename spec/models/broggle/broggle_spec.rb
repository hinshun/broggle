describe Broggle do
  let(:broggle) { build(:broggle) }

  it 'points to master' do
    expect(broggle.repo.head.name).to eq('refs/heads/master')
  end
end
