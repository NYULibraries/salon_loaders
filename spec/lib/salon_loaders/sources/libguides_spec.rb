require 'spec_helper'

describe SalonLoaders::Sources::Libguides do
  let(:libguides){ described_class.new }

  describe "#get_permalinks" do
    subject{ libguides.get_permalinks }
    let(:list){ instance_double LibGuides::API::Az::List, load: data }
    let(:data){ [api_asset1, api_asset2, api_asset3, api_asset4] }
    #let(:api_asset1){ instance_double LibGuides::API::Az::Asset, id: '1', url: 'https://arch.library.nyu.edu/databases/proxy/NYU00685', internal_note: "ONLY KARMS | oclc: null | force_proxy: False | use_proxy: True | url: https://search.alexanderstreet.com/qwst | staff_logs: Created - MK 06/14/2023" }
    let(:api_asset1){ instance_double LibGuides::API::Az::Asset, id: '1', url: 'https://persistent.library.nyu.edu/arch/NYU00685', internal_note: "ONLY KARMS | oclc: null | force_proxy: False | use_proxy: True | url: https://search.alexanderstreet.com/qwst | staff_logs: Created - MK 06/14/2023" }
    let(:api_asset2){ instance_double LibGuides::API::Az::Asset, id: '2', url: 'https://persistent.library.nyu.edu/arch/NYU01065', internal_note: "ONLY KARMS | oclc: 858354369 | force_proxy: False | use_proxy: True | url: http://search.proquest.com/ncjrs/advanced/ip | staff_logs: Edited - KM 6/1/2011, updated publisher, #Edited - KM 7/13/2011, see ProQuest Platform Switch Work for more information, #Edited - KM 10/4/2012 removed ?accountid=12768 and added /ip at end of URL to make all institution access work" }
    let(:api_asset3){ instance_double LibGuides::API::Az::Asset, id: '3', url: 'https://persistent.library.nyu.edu/arch/c68bab3a', internal_note: "ONLY KARMS | oclc: 883688239 | force_proxy: False | use_proxy: True | url: https://infoweb.newsbank.com/apps/readex/?p=ASLC | staff_logs: Updated URL from https://infoweb.newsbank.com/?db=ASLC&s_startsearch=keyword - JC 2/5/24, #Created - FM 8/19/2021" }
    let(:api_asset4){ instance_double LibGuides::API::Az::Asset, id: '4', url: 'https://persistent.library.nyu.edu/arch/SLNID3', internal_note: "ONLY KARMS | oclc: 647239825 | force_proxy: False | use_proxy: True | url: http://rotunda.upress.virginia.edu/founders/default.xqy?keys=FGEA-print&mode=TOC | staff_logs: Created - FM 9/18/2018" }
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
      context 'when no metalib id is in the internal note field' do
        context 'and PROXY_YES is present' do
          subject { libguides.get_permalinks.detect{|x| x.key == 'NYU00685' } }
          its(:url){ is_expected.to eq "https://proxy.library.nyu.edu/login?qurl=https%3A%2F%2Fsearch.alexanderstreet.com%2Fqwst" }
        end
      end
    end
    #describe "second permalink" do
    #  context 'when a metalib id is in the internal note field' do
    #    subject{ libguides.get_permalinks.detect{|x| x.key == 'NYU05226' } }
    #    its(:url){ is_expected.to eq "http://streaming.videatives.com/autologin/#/123" }
    #    its(:use_proxy){ is_expected.to be_falsy }

    #    context 'and the url has a Salon ID but PROXY_NO is present' do
    #      subject{ libguides.get_permalinks.detect{|x| x.key == 'SLNID1' } }
    #      its(:url){ is_expected.to eq "http://streaming.videatives.com/autologin/#/123" }
    #      its(:use_proxy){ is_expected.to be_falsy }
    #    end
    #  end
    #end
    #describe "third permalink" do
    #  context 'when no metalib id is in the internal note field' do
    #    context 'and the url has a Salon ID but PROXY_YES is present' do
    #      subject{ libguides.get_permalinks.detect{|x| x.key == 'SLNID2' } }
    #      its(:url){ is_expected.to eq "https://proxy.library.nyu.edu/login?qurl=http%3A%2F%2Fstreaming.videatives.com%2Fautologin%2F%23%2F123" }
    #      its(:use_proxy){ is_expected.to be_truthy }
    #    end
    #  end
    #end
  end

end
