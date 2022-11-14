require 'spec_helper.rb'
require './my_reverse_logger'
require './my_logger'

describe 'Reverse Logger Tests' do
   
    it 'writes messages in reverse' do
        expect(MyReverseLogger.new.info('hello world')).to eq('[INFO] dlrow olleh')
        expect(MyReverseLogger.new.warn('a warn')).to eq('[WARN] nraw a')
        expect(MyReverseLogger.new.error('an error')).to eq('[ERROR] rorre na')
    end
    it 'supports buffered output for reversing' do
        my_logger = MyReverseLogger.new(warn_size: 2, error_size: 3)
        expect(my_logger.info('hello')).to eq('[INFO] olleh')
        expect(my_logger.warn('blabla')).to be_nil
        expect(my_logger.warn('umbrella')).to eq(['[WARN] albalb', '[WARN] allerbmu'])
        expect(my_logger.warn('hello')).to be_nil
        expect(my_logger.error('oops')).to be_nil
        expect(my_logger.error('oopsie')).to be_nil
        expect(my_logger.warn('what')).to eq(['[WARN] olleh', '[WARN] tahw'])
        expect(my_logger.error('ouch')).to eq(['[ERROR] spoo', '[ERROR] eispoo', '[ERROR] hcuo'])
    end

    it "supports tagging for reverse class" do
        expect(MyReverseLogger.new.error('this is an error', 'API CALL')).to eq('[API CALL][ERROR] rorre na si siht')
        expect(MyReverseLogger.new.info('this is info', 'LOCALHOST:3000')).to eq('[LOCALHOST:3000][INFO] ofni si siht')
        expect(MyReverseLogger.new.warn('this is an warning', 'DB TRANSACTION')).to eq('[DB TRANSACTION][WARN] gninraw na si siht')
    end

end