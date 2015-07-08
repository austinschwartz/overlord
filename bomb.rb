class Bomb
  attr_accessor :acode, :dcode, :status
  
  class BootError < StandardError; end
  class ActivateError < StandardError; end
  class DeactivateError < StandardError; end

  TRIES_BEFORE_DETONATION = 3

  def initialize
    @status = :not_booted
  end
  
  def hash_keys_to_symbols(hash)
    hash.map do |k, v| 
      Hash[ k.to_s, v]
    end.reduce(:merge)
  end

  def boot(options={})
    options = hash_keys_to_symbols(options) unless options.empty?
    @acode = options.key?('acode') ? options['acode'].to_s : '1234'
    @dcode = options.key?('dcode') ? options['dcode'].to_s : '0000'
    @acode = '1234' if @acode == ''
    @dcode = '0000' if @dcode == ''
    raise BootError, 'Activation code is incorrect format' unless @acode.to_s =~ /^(\d{4})$/ 
    raise BootError, 'Deactivation code is incorrect format' unless @dcode.to_s =~ /^(\d{4})$/
    @status = :not_active
  end

  def activate(code)
    if code.to_s == @acode && !exploded? then
      @status = :active
      @deactivation_count = TRIES_BEFORE_DETONATION
    else
      raise ActivateError, exploded? ? 'Bomb has already exploded' : 'Incorrect activation code'
    end
  end

  def deactivate(code)
    if code.to_s == @dcode && !exploded? then
      @status = :not_active
      @detonation_count = TRIES_BEFORE_DETONATION
    else
      unless exploded? then
        @deactivation_count -= 1
        detonate if @deactivation_count == 0
        raise DeactivateError, 'Incorrect deactivation code. Warning: Bomb will detonate with ' +
          "#{@deactivation_count} more incorrect try(s)" if @deactivation_count > 0
      else
        raise DeactivateError, 'Bomb has already exploded'
      end
    end
  end

  def detonate
    @status = :exploded
  end

  def active?
    @status == :active
  end

  def not_active?
    @status == :not_active
  end

  def booted?
    @status != :not_booted
  end

  def exploded?
    @status == :exploded
  end
end
