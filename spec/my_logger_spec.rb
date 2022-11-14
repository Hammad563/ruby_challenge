require 'spec_helper.rb'
require './my_logger'

describe 'Logger Test' do
    it "supports info" do
        expect(MyLogger.new.info('hello world')).to eq('[INFO] hello world')
    end
    it 'supports warn' do
        expect(MyLogger.new.warn('this is a warning')).to eq('[WARN] this is a warning')
    end
    it 'supports error' do
        expect(MyLogger.new.error('this is an error')).to eq('[ERROR] this is an error')
    end

    it 'supports buffered output' do 
        my_logger = MyLogger.new(warn_size: 2, error_size: 3)
        expect(my_logger.info('hello')).to eq('[INFO] hello')
        expect(my_logger.warn('blabla')).to be_nil
        expect(my_logger.warn('umbrella')).to eq(['[WARN] blabla', '[WARN] umbrella'])
        expect(my_logger.warn('hello')).to be_nil
        expect(my_logger.error('oops')).to be_nil
        expect(my_logger.error('oopsie')).to be_nil
        expect(my_logger.warn('what')).to eq(['[WARN] hello', '[WARN] what'])
        expect(my_logger.error('ouch')).to eq(['[ERROR] oops', '[ERROR] oopsie', '[ERROR] ouch'])
    end

    it "supports tagging" do
        expect(MyLogger.new.error('this is an error', 'API CALL')).to eq('[API CALL][ERROR] this is an error')
        expect(MyLogger.new.info('this is info', 'LOCALHOST:3000')).to eq('[LOCALHOST:3000][INFO] this is info')
        expect(MyLogger.new.warn('this is an warning', 'DB TRANSACTION')).to eq('[DB TRANSACTION][WARN] this is an warning')
    end

end