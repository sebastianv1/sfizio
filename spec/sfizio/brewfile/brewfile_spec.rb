require 'spec_helper'

describe Sfizio::Brewfile do
  context "with Brewfile sample" do
    it 'parses contents' do
      contents = <<~EOS
      tap 'local'
      tap 'outside', url: 'git@git-tap'
      formula 'python', '1.0'
      formula 'cloc', '1.90_2'
      formula 'outer', '0.23.1', tap: 'outside_world'
      formula 'sqlite@3.0'
      formula 'sqlite@3.1', tap: 'outside_world'
      EOS

      subject = Sfizio::Brewfile.from_string(contents)
      formulas = [
        Sfizio::Formula.new('python', '1.0', nil),
        Sfizio::Formula.new('cloc', '1.90_2', nil),
        Sfizio::Formula.new('outer', '0.23.1', 'outside_world'),
        Sfizio::Formula.new('sqlite@3.0', nil, nil),
        Sfizio::Formula.new('sqlite@3.1', nil, 'outside_world')
      ]
      expect(subject.formulas).to eq formulas
      expect(subject.taps).to eq [Sfizio::Tap.new('local', nil), Sfizio::Tap.new('outside', 'git@git-tap')]
    end
  end

  it 'should parse an empty file' do
    contents = <<~EOS
    EOS
    subject = Sfizio::Brewfile.from_string(contents)
    expect(subject.formulas.length).to eq 0
  end
end