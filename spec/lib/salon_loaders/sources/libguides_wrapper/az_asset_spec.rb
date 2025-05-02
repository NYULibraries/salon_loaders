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
      context "and use_proxy: True is present" do
        let(:internal_note){ 'ONLY KARMS | oclc: 1136611195 | force_proxy: False | use_proxy: True | url: https://search.alexanderstreet.com/qwst | staff_logs: Created - MK 06/14/2023' }
        it { is_expected.to be_truthy }
      end
      context "but use_proxy: False is present" do
        let(:internal_note){ 'ONLY KARMS | oclc: 1136611195 | force_proxy: True | use_proxy: False | url: https://search.alexanderstreet.com/qwst | staff_logs: Created - MK 06/14/2023' }
        it { is_expected.to be_falsy }
      end
      context "and any other value is present" do
        let(:internal_note){ 'ONLY KARMS | oclc: null | force_proxy: True | PROXY_YES | url: https://search.alexanderstreet.com/qwst | staff_logs: Created - MK 06/14/2023' }
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
        let(:internal_note){ "ONLY KARMS | oclc: 1136611195 | force_proxy: False | use_proxy: True | url: http://dl.acm.org/dl.cfm | staff_logs: Created - MK 06/14/2023" }
        it { is_expected.to eq "http://dl.acm.org/dl.cfm" }
      end
      context "with invalid internal_note URL" do
        let(:internal_note){ "ONLY KARMS | oclc: 1136611195 | force_proxy: False | use_proxy: True | url: notavalidurl | staff_logs: Created - MK 06/14/2023" }
        it { is_expected.to eq nil }
      end
      context "with invalid internal_note ID in null form" do
        let(:internal_note){ "ONLY KARMS | oclc: null | force_proxy: False | use_proxy: True | url: http://dl.acm.org/dl.cfm | staff_logs: Created - MK 06/14/2023" }
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
        it { is_expected.to eq nil }
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
