require 'spec_helper'
require 'test_doubles'

describe 'ContextFactory - used with AdditionOrganizer' do
  context 'when called with the first action' do
    it 'does not alter the context' do
      ctx =
        LightService::Testing::ContextFactory
        .make_from(TestDoubles::AdditionOrganizer)
        .for(TestDoubles::AddsOneAction)
        .with(:number => 1)

      expect(ctx[:number]).to eq(1)
    end
  end

  context 'when called with the second action' do
    it 'adds one to the number provided' do
      ctx =
        LightService::Testing::ContextFactory
        .make_from(TestDoubles::AdditionOrganizer)
        .for(TestDoubles::AddsTwoAction)
        .with(:number => 1)

      expect(ctx.number).to eq(2)
    end
  end

  context 'when called with third action' do
    it 'creates a context up-to the action defined' do
      ctx =
        LightService::Testing::ContextFactory
        .make_from(TestDoubles::AdditionOrganizer)
        .for(TestDoubles::AddsThreeAction)
        .with(:number => 1)

      expect(ctx.number).to eq(4)
    end
  end

  context 'when called with an invalid action' do
    let(:invalid_action) { TestDoubles::MakesLatteAction }
    let(:organizer) { TestDoubles::AdditionOrganizer }

    it 'raises an argument error' do
      expect {
        LightService::Testing::ContextFactory
          .make_from(organizer)
          .for(invalid_action)
          .with(:number => 1)
      }.to raise_error(
        ArgumentError,
        "#{invalid_action} is not in #{organizer}"
      )
    end
  end
end
