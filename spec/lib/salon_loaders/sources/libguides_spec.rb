require 'spec_helper'

describe SalonLoaders::Sources::Libguides do
  let(:libguides){ described_class.new }

  describe "#get_permalinks" do
    subject{ libguides.get_permalinks }
    let(:list){ instance_double LibGuides::API::Az::List, load: data }
    let(:data){ [api_asset1, api_asset2, api_asset3, api_asset4] }
    let(:api_asset1){ instance_double LibGuides::API::Az::Asset, id: '1', url: 'https://arch.library.nyu.edu/databases/proxy/NYU00685', library_review: "ONLY KARMS | NYU00685 | PROXY_YES | http://link.springer.com/search?showAll=false" }
    let(:api_asset2){ instance_double LibGuides::API::Az::Asset, id: '2', url: 'https://persistent.library.nyu.edu/arch/SLNID1', library_review: "ONLY KARMS | NYU05226 | PROXY_NO | http://streaming.videatives.com/autologin/#/123" }
    let(:api_asset3){ instance_double LibGuides::API::Az::Asset, id: '3', url: 'https://persistent.library.nyu.edu/arch/SLNID2', library_review: "ONLY KARMS | NULL | PROXY_YES | http://streaming.videatives.com/autologin/#/123" }
    let(:api_asset4){ instance_double LibGuides::API::Az::Asset, id: '4', url: 'https://persistent.library.nyu.edu/arch/SLNID3', library_review: "" }
    before do
      allow(LibGuides::API::Az::List).to receive(:new).and_return list
    end
    it { is_expected.to be_an Array }
    it 'should have correct size' do
      expect(subject.length).to eq 4
    end
    it 'should have correct members' do
      expect(subject[0]).to be_a SalonLoaders::Permalink
      expect(subject[1]).to be_a SalonLoaders::Permalink
      expect(subject[2]).to be_a SalonLoaders::Permalink
      expect(subject[3]).to be_a SalonLoaders::Permalink
    end
    describe 'first permalink' do
      context 'when a metalib id is in the library review field' do
        context 'and PROXY_YES is present' do
          subject { libguides.get_permalinks.detect{|x| x.key == 'NYU00685' } }
          its(:url){ is_expected.to eq "https://proxy.library.nyu.edu/login?qurl=http%3A%2F%2Flink.springer.com%2Fsearch%3FshowAll%3Dfalse" }
        end
      end
    end
    describe "second permalink" do
      context 'when a metalib id is in the library review field' do
        subject{ libguides.get_permalinks.detect{|x| x.key == 'NYU05226' } }
        its(:url){ is_expected.to eq "http://streaming.videatives.com/autologin/#/123" }
        its(:use_proxy){ is_expected.to be_falsy }

        context 'and the url has a Salon ID but PROXY_NO is present' do
          subject{ libguides.get_permalinks.detect{|x| x.key == 'SLNID1' } }
          its(:url){ is_expected.to eq "http://streaming.videatives.com/autologin/#/123" }
          its(:use_proxy){ is_expected.to be_falsy }
        end
      end
    end
    describe "third permalink" do
      context 'when no metalib id is in the library review field' do
        context 'and the url has a Salon ID but PROXY_YES is present' do
          subject{ libguides.get_permalinks.detect{|x| x.key == 'SLNID2' } }
          its(:url){ is_expected.to eq "https://proxy.library.nyu.edu/login?qurl=http%3A%2F%2Fstreaming.videatives.com%2Fautologin%2F%23%2F123" }
          its(:use_proxy){ is_expected.to be_truthy }
        end
      end
    end
  end

end
