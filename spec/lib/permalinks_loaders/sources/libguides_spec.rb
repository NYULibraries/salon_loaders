require 'spec_helper'

describe PermalinksLoaders::Sources::Libguides do
  let(:libguides){ described_class.new }

  describe "get_permalinks" do
    subject{ libguides.get_permalinks }
    let(:list){ instance_double LibGuides::API::Az::List, load: data }
    let(:data){ [api_asset1, api_asset2, api_asset3] }
    let(:api_asset1){ instance_double LibGuides::API::Az::Asset, id: '1', meta: nil, library_review: "ONLY KARMS | NYU00685 | http://link.springer.com/search?showAll=false" }
    let(:api_asset2){ instance_double LibGuides::API::Az::Asset, id: '2', meta: {"enable_proxy" => 1}, library_review: "ONLY KARMS | NYU05226 | http://streaming.videatives.com/autologin/4b54c47c82eb34803df4a65b48c21290c3a42aef" }
    let(:api_asset3){ instance_double LibGuides::API::Az::Asset, id: '3', meta: {"enable_proxy" => ""}, library_review: "" }
    before do
      allow(LibGuides::API::Az::List).to receive(:new).and_return list
    end

    it { is_expected.to be_an Array }
    it "should have correct size" do
      expect(subject.length).to eq 4
    end
    it "should have correct members" do
      expect(subject[0]).to be_a PermalinksLoaders::Permalink
      expect(subject[1]).to be_a PermalinksLoaders::Permalink
      expect(subject[2]).to be_a PermalinksLoaders::Permalink
      expect(subject[3]).to be_a PermalinksLoaders::Permalink
    end
    describe "first permalink (libguides id)" do
      subject{ libguides.get_permalinks.detect{|x| x.key == '1' } }
      its(:url){ is_expected.to eq "http://link.springer.com/search?showAll=false" }
      its(:use_proxy){ is_expected.to be_falsy }
    end
    describe "first permalink (metalib id)" do
      subject{ libguides.get_permalinks.detect{|x| x.key == 'NYU00685' } }
      its(:url){ is_expected.to eq "http://link.springer.com/search?showAll=false" }
      its(:use_proxy){ is_expected.to be_falsy }
    end
    describe "second permalink (libguides id)" do
      subject{ libguides.get_permalinks.detect{|x| x.key == '2' } }
      its(:url){ is_expected.to eq "https://ezproxy.library.nyu.edu/login?url=http://streaming.videatives.com/autologin/4b54c47c82eb34803df4a65b48c21290c3a42aef" }
      its(:use_proxy){ is_expected.to be_truthy }
    end
    describe "second permalink (metalib id)" do
      subject{ libguides.get_permalinks.detect{|x| x.key == 'NYU05226' } }
      its(:url){ is_expected.to eq "https://ezproxy.library.nyu.edu/login?url=http://streaming.videatives.com/autologin/4b54c47c82eb34803df4a65b48c21290c3a42aef" }
      its(:use_proxy){ is_expected.to be_truthy }
    end
  end
end
