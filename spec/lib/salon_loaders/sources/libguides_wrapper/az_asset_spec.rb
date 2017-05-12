require 'spec_helper'

describe SalonLoaders::Sources::LibguidesWrapper::AzAsset do
  let(:asset){ described_class.new libguides_asset }
  let(:libguides_asset) do
    instance_double(LibGuides::API::Az::Asset,
      id: "11155149",
      library_review: library_review,
      meta: meta,
    )
  end
  let(:meta){ nil }
  let(:library_review){ nil }

  describe "enable_proxy?" do
    subject{ asset.enable_proxy? }

    context "with meta" do
      context "with proxy true" do
        let(:meta){ {"enable_proxy"=>1} }
        it { is_expected.to be_truthy }
      end
      context "with proxy not true" do
        let(:meta){ {"enable_proxy"=>0} }
        it { is_expected.to be_falsy }
      end
    end
    context "without meta" do
      it { is_expected.to be_falsy }
    end
  end

  describe "url" do
    subject{ asset.url }
    context "with library_review" do
      context "with valid library_review" do
        let(:library_review){ "ONLY KARMS | NYU00676 | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq "http://dl.acm.org/dl.cfm" }
      end
      context "with invalid library_review URL" do
        let(:library_review){ "ONLY KARMS | NYU00676 | applesauce |" }
        it { is_expected.to eq nil }
      end
      context "with invalid library_review ID in null form" do
        let(:library_review){ "ONLY KARMS | NULL | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq "http://dl.acm.org/dl.cfm" }
      end
      context "with invalid library_review ID not in null form" do
        let(:library_review){ "ONLY KARMS | gobbledigook | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq nil }
      end
    end
    context "without library_review" do
      it { is_expected.to eq nil }
    end
  end

  describe "metalib_id" do
    subject{ asset.metalib_id }
    context "with library_review" do
      context "with valid library_review" do
        let(:library_review){ "ONLY KARMS | NYU00676 | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq "NYU00676" }
      end
      context "with invalid library_review URL" do
        let(:library_review){ "ONLY KARMS | NYU00676 | applesauce |" }
        it { is_expected.to eq nil }
      end
      context "with invalid library_review ID in null form" do
        let(:library_review){ "ONLY KARMS | NULL | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq nil }
      end
      context "with invalid library_review ID not in null form" do
        let(:library_review){ "ONLY KARMS | gobbledigook | http://dl.acm.org/dl.cfm |" }
        it { is_expected.to eq nil }
      end
    end
    context "without library_review" do
      it { is_expected.to eq nil }
    end
  end
end
