describe Broggle do
  let(:broggle) { build(:broggle) }

  it 'has 5 branches' do
    expect(broggle.repo.branches.count).to eq(5)
  end
end
