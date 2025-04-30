require 'spec_helper'

describe SalonLoaders::Sources::LibguidesWrapper::AzAsset do
  let(:asset){ described_class.new libguides_asset }
  let(:libguides_asset) do
    instance_double(LibGuides::API::Az::Asset,
      id: "11155149",
      url: url,
      internal_note: internal_note
    )
  end
  let(:salon_id) { "00a791d8" }
  let(:url) { "https://persistent.library.nyu.edu/arch/#{salon_id}" }
  let(:meta){ nil }
  let(:internal_note){ nil }

  describe '#enable_proxy?' do
    subject{ asset.enable_proxy? }

    context "when internal_note is present" do
      context "and PROXY_YES is present" do
        let(:internal_note){ 'ONLY KARMS | NYU00685 | PROXY_YES | http://url' }
        it { is_expected.to be_truthy }
      end
      context "but PROXY_NO is present" do
        let(:internal_note){ 'ONLY KARMS | NYU00685 | PROXY_NO | http://url' }
        it { is_expected.to be_falsy }
      end
      context "and any other value is present" do
        let(:internal_note){ 'ONLY KARMS | NYU00685 | INVALID | http://url' }
        it { is_expected.to be_falsy }
      end
    end
    context "when internal_note is missing" do
      it { is_expected.to be_falsy }
    end
  end

  describe '#resource_url' do
    subject{ asset.resource_url }
    context "with internal_note" do
      context "with valid internal_note" do
        let(:internal_note){ "ONLY KARMS | NYU00676 | PROXY_NO | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq "http://dl.acm.org/dl.cfm" }
      end
      context "with invalid internal_note URL" do
        let(:internal_note){ "ONLY KARMS | NYU00676 | PROXY_NO |applesauce |" }
        it { is_expected.to eq nil }
      end
      context "with invalid internal_note ID in null form" do
        let(:internal_note){ "ONLY KARMS | NULL | PROXY_YES | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq "http://dl.acm.org/dl.cfm" }
      end
      context "with invalid internal_note ID not in null form" do
        let(:internal_note){ "ONLY KARMS | gobbledigook | PROXY_NO | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq nil }
      end
    end
    context "without internal_note" do
      it { is_expected.to eq nil }
    end
  end

  describe '#metalib_id' do
    subject{ asset.metalib_id }
    context "with internal_note" do
      context "with valid internal_note" do
        let(:internal_note){ "ONLY KARMS | NYU00676 | PROXY_NO | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq "NYU00676" }
      end
      context "with invalid internal_note URL" do
        let(:internal_note){ "ONLY KARMS | NYU00676 | PROXY_YES | applesauce |" }
        it { is_expected.to eq nil }
      end
      context "with invalid internal_note ID in null form" do
        let(:internal_note){ "ONLY KARMS | NULL | PROXY_NO | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq nil }
      end
      context "with invalid internal_note ID not in null form" do
        let(:internal_note){ "ONLY KARMS | gobbledigook | PROXY_YES | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq nil }
      end
    end
    context "without internal_note" do
      it { is_expected.to eq nil }
    end
  end

  describe '#salon_id' do
    subject { asset.salon_id }

    context 'when url is a salon url' do
      it { is_expected.to eql salon_id }
    end
    context 'when url is not a salon url' do
      let(:url) { 'https://arch.library.nyu.edu/databases/proxy/NYU12345' }
      it { is_expected.to be_nil }
    end
  end
end
