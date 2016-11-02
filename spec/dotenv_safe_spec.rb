require "spec_helper"

describe DotenvSafe do
  let(:rail_tie) { DotenvSafe::Railtie.send(:new) }

  describe '#check_env_vars' do
    let(:valid_env_file_contents) do
      [
        "FOO=bar\n",
        "BAR=\n",
      ].join('')
    end

    let(:invalid_env_file_contents) do
      [
        "FOO=\n",
        "BAR=foo\n",
        "NOT_SET_1=foo\n",
        "NOT_SET_2=\n",
      ].join('')
    end

    before do
      allow(ENV).to receive(:fetch)
      allow(ENV).to receive(:fetch).with('FOO').and_return('bar')
      allow(ENV).to receive(:fetch).with('BAR').and_return('foo')
      allow(ENV).to receive(:fetch).with('NOT_SET_1').and_raise(KeyError)
      allow(ENV).to receive(:fetch).with('NOT_SET_2').and_raise(KeyError)
    end

    context 'with all required environment variables set' do
      it 'should not raise an error when all the variables are present' do
        allow(rail_tie).to receive(:read).and_return(valid_env_file_contents)
        expect { rail_tie.check_env_vars }.to_not raise_error
      end
    end

    context 'with some required environment variables not set' do
      it 'should raise an error when missing required environment variables' do
        allow(rail_tie).to receive(:read).and_return(invalid_env_file_contents)
        expect {
          rail_tie.check_env_vars
        }.to raise_error(DotenvSafe::MissingEnvVarError)
      end
    end
  end

  describe '#example_env_vars' do
    context 'with no .env.example file' do
      it 'returns an empty array if no file found' do
        expect(rail_tie.send(:example_env_vars)).to eq({})
      end
    end

    context 'with .env.example file' do
      context 'with no valid environment variables' do
        let(:invalid_env_file_contents) do
          [
            "foo\n",
            "bar\n",
            "stuff\n",
          ].join('')
        end

        before do
          allow(rail_tie).to receive(:read).and_return(invalid_env_file_contents)
        end

        it 'returns an empty hash' do
          expect(rail_tie.send(:example_env_vars)).to eq({})
        end
      end

      context 'with valid environment variables' do
        context 'without comments' do
          let(:valid_env_file_contents) do
            [
              "FOO_VAR=bar\n",
              "BAR_VAR=foo\n",
            ].join('')
          end

          before do
            allow(rail_tie).to receive(:read).and_return(valid_env_file_contents)
          end

          it 'returns some example env vars' do
            expect(rail_tie.send(:example_env_vars)).to eq({
              'FOO_VAR' => 'bar',
              'BAR_VAR' => 'foo',
            })
          end
        end

        context 'with comments' do
          let(:valid_env_file_contents) do
            [
              "FOO_VAR=bar\n",
              "# BAR_VAR=foo\n",
            ].join('')
          end

          before do
            allow(rail_tie).to receive(:read).and_return(valid_env_file_contents)
          end

          it 'returns non-commented out example env vars' do
            expect(rail_tie.send(:example_env_vars)).to eq({
              'FOO_VAR' => 'bar',
            })
          end
        end
      end
    end
  end
end
