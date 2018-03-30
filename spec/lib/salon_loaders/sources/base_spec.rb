require 'spec_helper'

describe SalonLoaders::Sources::Base do
  let(:base){ described_class.new }
  let!(:source_data) do
    [
      SalonLoaders::Permalink.new(key: '1', url: 'http://nyu.edu'),
      SalonLoaders::Permalink.new(key: '2', url: 'http://google.com')
    ]
  end
  before do
    allow_any_instance_of(SalonLoaders::Sources::Base).to receive(:source_data).and_return source_data
    allow_any_instance_of(SalonLoaders::Sources::Base).to receive(:key_field).and_return :key
    allow_any_instance_of(SalonLoaders::Sources::Base).to receive(:url_field).and_return :url
    allow(File).to receive(:open).and_return 22
  end

  describe '#permalinks' do
    subject { base.permalinks }
    it { is_expected.to be_instance_of Array }
  end

  describe '#write_txt' do
    subject { base.write_txt('./test.txt') }
    it 'should not raise an error when writing txt file' do
      expect { subject }.to_not raise_error
    end
  end

  describe '#write_json' do
    subject { base.write_json('./test.json') }
    it 'should not raise an error when writing json file' do
      expect { subject }.to_not raise_error
    end
  end

  describe '#to_txt' do
    subject { base.to_txt }
    it { is_expected.to include "set 1 http://nyu.edu\r\n" }
  end

  describe '#to_json' do
    subject { base.to_json }
    it { is_expected.to eq "[{\"id\":\"1\",\"url\":\"http://nyu.edu\"},{\"id\":\"2\",\"url\":\"http://google.com\"}]" }
  end
end
