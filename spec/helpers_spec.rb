require 'spec_helper'

describe Grom::Helpers do

  let(:extended_class) { Class.new { extend Grom::Helpers } }

  describe '#url_builder' do
    it 'should return an endpoint when given a class and an associated class' do
      dummy = DummyPerson.find(PERSON_ONE_GRAPH)
      url = extended_class.url_builder(dummy, "Party")
      expect(url).to eq "#{API_ENDPOINT}/dummy_people/1/parties.ttl"
    end

    it 'should return an endpoint when given a class, an associated class and an optional' do
      dummy = DummyPerson.find(PERSON_ONE_GRAPH)
      url = extended_class.url_builder(dummy, "Party", "current")
      expect(url).to eq "#{API_ENDPOINT}/dummy_people/1/parties/current.ttl"
    end
  end

  describe '#create_class_name' do
    it 'should camelize, capitalize and singularize any plural underscore properties' do
      expect(extended_class.create_class_name('dummy_party_memberships')).to eq 'DummyPartyMembership'
    end
  end

  describe '#create_property_name' do
    it 'should underscore, downcase and pluralize any singular class name' do
      expect(extended_class.create_property_name('DummyPerson')).to eq 'dummy_people'
    end
  end

end