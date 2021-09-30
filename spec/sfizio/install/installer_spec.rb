require 'spec_helper'

describe Sfizio::Installer do
  let(:test_logger) { Logger.new('/dev/null') }

  context 'when configuring the local tap' do
    let(:brewfile) { Sfizio::Brewfile.new([]) }
    let(:installer) { described_class.new(brewfile, false, test_logger) }
    it "creates a new tap if one doesn't exist" do
      allow(Sfizio::Brew::TapInfo).to receive(:tap_path).and_return(Sfizio::Brew::TapInfo.new({}, false))
      expect(Sfizio::Brew::TapNew).to receive(:tap_new!).and_return(nil)
      installer.install!
    end

    it 'skips creation when the tap exists' do
      allow(Sfizio::Brew::TapInfo).to receive(:tap_path).and_return(Sfizio::Brew::TapInfo.new({}, true))
      expect(Sfizio::Brew::TapNew).not_to receive(:tap_new!)
      installer.install!
    end
  end

  context 'when installing with existing links' do
    let(:cloc_formula) { Sfizio::Formula.new('cloc', '1.9.0', nil ) }
    let(:brewfile) { Sfizio::Brewfile.new([cloc_formula]) }
    let(:installer) { described_class.new(brewfile, false, test_logger) }

    it 'unlinks all existing linked formulae' do
      allow(Sfizio::Brew::Info).to receive(:formula).and_return(Sfizio::Brew::Info.new({"installed" => []}, true))
      allow(Sfizio::Brew::Install).to receive(:formula).and_return(nil)

      allow(Sfizio::Brew::TapInfo).to receive(:tap_path).and_return(Sfizio::Brew::TapInfo.new({}, true))
      allow(cloc_formula).to receive(:fuzzy_linked_kegs).and_return(["cloc", "cloc@1.88"])
      expect(Sfizio::Brew::Link).to receive(:unlink).twice.and_return(nil)

      installer.install!
    end
  end

  context 'when installing' do
    let(:brewfile) { Sfizio::Brewfile.new([]) }
    let(:installer) { described_class.new(brewfile, true, test_logger) }
    it 'calls into brew update if update flag is passed' do
      allow(Sfizio::Brew::TapInfo).to receive(:tap_path).and_return(Sfizio::Brew::TapInfo.new({}, true))
      expect(Sfizio::Brew::Update).to receive(:run).and_return(nil)
      installer.install!
    end
  end
end