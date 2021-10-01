require 'spec_helper'

describe Sfizio::Clean do
  context 'when clean is invoked with a Brewfile' do
    let(:brewfile) { Sfizio::Brewfile.new([Sfizio::Formula.new('cloc', '2.9', nil)]) }
    let(:cleaner) { described_class.new(Sfizio::TAP_PATH, brewfile) }
    it 'uninstalls all Brewfile formula' do
      allow(Sfizio::Brew::Tap).to receive(:untap).and_return(nil)
      expect(Sfizio::Brew::Uninstall).to receive(:formula).with("#{Sfizio::TAP_PATH}/cloc@2.9").and_return(nil)
      cleaner.clean!
    end

    it 'untaps the local tap' do
      expect(Sfizio::Brew::Tap).to receive(:untap).with(Sfizio::TAP_PATH, force: true).and_return(nil)
      allow(Sfizio::Brew::Uninstall).to receive(:formula).and_return(nil)
      cleaner.clean!
    end
  end

  context 'when clean is invoked without a Brewfile' do
    let(:cleaner) { described_class.new(Sfizio::TAP_PATH, nil) }

    it 'accepts a nil Brewfile' do
      expect(Sfizio::Brew::Tap).to receive(:untap).with(Sfizio::TAP_PATH, force: true).and_return(nil)
      expect(Sfizio::Brew::Uninstall).not_to receive(:formula)
      cleaner.clean!
    end
  end
end