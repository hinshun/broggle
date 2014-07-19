describe Broggle::Broggle do
  let(:broggle) { build :broggle }
  before(:example) { RuggedSpecHelper.prepare_repo }

  describe '#repo' do
    subject { broggle.repo }
    it { is_expected.to be_a Rugged::Repository }
  end

  describe '#branches' do
    subject { broggle.branches }

    context ':name' do
      subject { super().map(&:name) }

      context 'when initialized' do
        it { is_expected.to include 'master' }
      end

      context 'when creating a new branch' do
        before { broggle.repo.create_branch('branch') }
        it { is_expected.to include 'branch' }
      end

      context 'when creating a new broggle' do
        before { broggle.create_broggle('master') }
        it 'should not include any that starts with "broggle_"' do
          is_expected.to_not include start_with 'broggle_'
        end
      end
    end
  end

  describe '#current_branch' do
    subject { broggle.current_branch }

    context 'when on `master`' do
      before { broggle.repo.checkout('master') }
      it { is_expected.to eq 'master' }
    end

    context 'when repository is headless' do
      before do
        head_oid = broggle.repo.head.target.oid
        broggle.repo.checkout(head_oid)
      end
      it { is_expected.to eq 'HEAD' }
    end
  end

  describe '#deploy' do
    subject { broggle.deploy(branches) }
    let(:branches) { {base: 'master', merges: []} }

    it do
      expect {
        subject
      }.to change(broggle, :current_branch).to start_with 'broggle_'
    end
  end

  describe '#create_broggle' do
    subject { broggle.create_broggle('master') }

    it 'creates a branch' do
      expect { subject }.to change(broggle.repo.branches, :count).by 1
    end

    context 'broggle branch name' do
      subject { super().name }
      it { is_expected.to start_with 'broggle_' }
    end
  end

  describe '#merge' do
    subject { broggle.merge(branch) }
    let(:branch) { RuggedSpecHelper.current_branch }
    before do
      RuggedSpecHelper.create_scenario(scenario)
      broggle_branch = broggle.create_broggle('master')
      broggle.repo.checkout(broggle_branch)
    end

    context 'when there are no conflicts' do
      let(:scenario) { :no_conflict }
      it { is_expected.to be :merge_success }
    end

    context 'when there are conflicts' do
      let(:scenario) { :conflict }
      it { is_expected.to be :merge_conflict }
    end
  end

  describe '#branches_substring_search' do
    subject { broggle.branches_substring_search(query) }

    context 'when searching for `ma`' do
      let(:query) { 'ma' }
      it { is_expected.to include 'master' }
    end

    context 'when searching for `mastre`' do
      let(:query) { 'mastre' }
      it { is_expected.to be_empty }
    end

    context 'when searching for `maer`' do
      let(:query) { 'maer' }
      it { is_expected.to be_empty }
    end
  end

  describe '#branches_flex_score' do
    subject { broggle.branches_flex_score(query) }

    let(:query) { '' }
    it { is_expected.to all include :score }

    context 'when scoring for `ma`' do
      let(:query) { 'ma' }
      it 'should include {name: "master"}' do
        is_expected.to include(include name: 'master')
      end
    end

    context 'when scoring for `mastre`' do
      let(:query) { 'mastre' }
      it { is_expected.to be_empty }
    end

    context 'when scoring for `maer`' do
      let(:query) { 'maer' }
      it 'should include {name: "master"}' do
        is_expected.to include(include name: 'master')
      end
    end
  end
end
