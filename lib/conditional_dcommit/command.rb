#!/usr/bin/env ruby

require 'rubygems'
require 'open4'

require 'conditional_dcommit/package'

module ConditionalDcommit
  class Command
    attr_accessor :status_code

    def test_command
      @test_command ||= ENV['TEST_COMMAND'] || 'script/cruise'
    end

    def code_tests_ok?
      puts "testing code"
      system(test_command) ? true : false
    end

    def dcommit
      puts "dcommitting"
      system("git svn dcommit") ? true : false
    end

    def rebase
      puts "rebasing"
      pid, stdin, stdout, stderr = Open4.popen4('git svn rebase')
      firstline = nil

      until (firstline = stdout.gets) || (firsterror = stderr.gets)
      end

      puts "firstline: #{firstline}"
      puts "firsterror: #{firsterror}"

      matcher = /Current branch .* is up to date./

      if (firsterror && firsterror.chomp =~ matcher) ||
         (firstline && firstline.chomp =~ matcher)
        retval = false
      else
        puts firstline || firsterror

        while line = stdout.gets || stderr.gets
          puts line
        end
        retval = true
      end

      ignored, status = Process::waitpid2 pid

      raise StandardError.new("Error rebasing") if status != 0

      puts "rebase return: #{retval.to_s}"

      retval
    end

    def report_fail(message="Failed dcommit")
      puts message
      self.status_code = 255
      growl('FAIL', message, Package.data_file('stop_sign.jpg'))
    end

    def report_success(message="Successful dcommit")
      puts message
      self.status_code = 0
      growl('Success', message, Package.data_file('traffic_green.jpg'))
    end

    def growl(title, message, image, stick="yes")
      growlNotify_file = Package.data_file('growlNotify.applescript')

      system "osascript #{growlNotify_file} '#{title}' '#{message}' '#{image}' #{stick}"
    end

    def main
      self.status_code = 254

      begin
        rebase

        5.times do
          if code_tests_ok?
            unless rebase
              raise StandardError.new("Error dcommitting") unless dcommit
              report_success
              break
            end
          else
            raise StandardError.new("Code tests failed")
          end
        end && report_fail("Too many tries")
      rescue StandardError => err
        report_fail(err.to_s)
      end

      self.status_code
    end
  end
end
