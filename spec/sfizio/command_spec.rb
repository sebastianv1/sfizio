require 'spec_helper'

describe Sfizio::Command do
  context 'when invoked' do
    it 'run install and looks for Brewfile' do
      expect(File).to receive(:exist?).and_return(true)
      allow(Sfizio::Brewfile).to receive(:from_file).and_return(Sfizio::Brewfile.new())
      expect_any_instance_of(Sfizio::Installer).to receive(:install!).and_return(nil)

      command = described_class.new(['install'])
      command.run!
    end

    it 'run clean' do
      expect_any_instance_of(Sfizio::Clean).to receive(:clean!).and_return(nil)
      
      command = described_class.new(['clean'])
      command.run!
    end

    it 'fails unknown commands' do      
      command = described_class.new(['unknown'])
      begin
        command.run!
      rescue SystemExit=>e
        expect(e.status).to eq(1)
      end
    end
  end
end