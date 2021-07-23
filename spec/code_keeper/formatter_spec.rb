# frozen_string_literal: true

RSpec.describe CodeKeeper::Formatter do
  describe '.format' do
    let(:expected_string) do
      <<~EOS
	Scores:
	filename: /foo/bar/code_keeper/spec/fixtures/branch_in_loop.rb
	score: 2
	---
	filename: /foo/bar/code_keeper/spec/fixtures/target_sample.rb
	score: 1
	---
      EOS
    end

    before do
      @result = {
        '/foo/bar/code_keeper/spec/fixtures/branch_in_loop.rb': 2,
        '/foo/bar/code_keeper/spec/fixtures/target_sample.rb': 1
      }
    end

    it 'returns an string' do
      expect(CodeKeeper::Formatter.format(@result)).to eq expected_string
    end
  end
end
