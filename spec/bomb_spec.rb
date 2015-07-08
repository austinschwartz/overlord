require_relative '../bomb'

describe Bomb do
  it 'should not be active when first booted' do
    bomb = Bomb.new
    expect(bomb.status).to equal(:not_booted)
  end  

  it 'should default activation code to 1234' do
    bomb = Bomb.new
    bomb.boot
    expect(bomb.acode).to eq('1234')
  end

  it 'should default deactivation code to 0000' do
    bomb = Bomb.new
    bomb.boot
    expect(bomb.dcode).to eq('0000')
  end

  it 'should default deactivation code to 0000 with keys passed with empty values' do
    bomb = Bomb.new
    bomb.boot(dcode: '')
    expect(bomb.dcode).to eq('0000')
  end

  it 'should throw an error on entering non-numeric into code field' do
    bomb = Bomb.new
    expect { bomb.boot(acode: 'asd') }.to raise_error
  end

  it 'should throw an error on entering combinations of digits where length != 4' do
    bomb = Bomb.new
    expect { bomb.boot(dcode: '12345') }.to raise_error
  end

  it 'should activate when the correct activation code is entered' do
    bomb = Bomb.new
    bomb.boot(acode: 2823)
    bomb.activate(2823)
    expect(bomb.status).to eq(:active)
  end

  it 'should not do anything if the activation code is entered again' do
    bomb = Bomb.new
    bomb.boot(acode: 1822)
    bomb.activate(1822)
    bomb.activate(1822)
    expect(bomb.status).to eq(:active)
  end

  it 'should deactivate when the correct deactivation code is entered' do
    bomb = Bomb.new
    bomb.boot(acode: 9933, dcode: 2922)
    bomb.activate(9933)
    bomb.deactivate(2922)
    expect(bomb.status).to eq(:not_active)
  end

  it 'should not explode if the wrong deactivation code is put in 2 times' do
    bomb = Bomb.new
    bomb.boot(acode: 1111, dcode: 2222)
    bomb.activate(1111)
    expect(bomb.status).to eq(:active)
    2.times {
      expect {
        bomb.deactivate(9888)
      }.to raise_error
    }
    expect(bomb.status).to eq(:active)
  end

  it 'should explode if the wrong deactivation code is put in 3 times' do
    bomb = Bomb.new
    bomb.boot(acode: 1111, dcode: 2222)
    bomb.activate(1111)
    2.times {
      expect {
        bomb.deactivate(9888)
      }.to raise_error
    }
    bomb.deactivate(9888)
    expect(bomb.status).to eq(:exploded)
  end

  it 'should not do anything once the bomb has exploded' do
    bomb = Bomb.new
    bomb.boot(acode: 1111, dcode: 2222)
    bomb.detonate
    expect { bomb.deactivate(2222) }.to raise_error
  end
end
