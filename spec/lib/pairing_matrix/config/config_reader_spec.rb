require './lib/pairing_matrix/config/config'
require './lib/pairing_matrix/config/config_reader'

describe PairingMatrix::ConfigReader do
    describe '#config' do
      context 'Github' do
        it 'should read github configuration' do
          config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/github_repositories.yml')
          configuration = config_reader.config

          expect(configuration.github.repositories.size).to eql(2)
          expect(configuration.github.repositories).to eql(['github_username/my_private_repo_1', 'github_username/my_private_repo_2'])
          expect(configuration.github.access_token).to eql('000324cff69wes5613f732c345hn679c0knt509c')
          expect(configuration.github.url).to eq('https://api.github.com/')
          expect(configuration.github.authors_regex).to eql('^.*\[([\w]*)(?:\/)?([\w]*)\].*$')
        end
      end

      context 'Local' do
        it 'read local repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/local_repositories.yml')
            configuration = config_reader.config

            expect(configuration.local.repositories.size).to eql(3)
            expect(configuration.local.repositories).to eql([
                '/Users/Ajit/projects/project1',
                '/Users/Ajit/projects/project2',
                '/Users/Ajit/projects/project3'
                ])
            expect(configuration.local.authors_regex).to eql('^.*\[([\w]*)(?:\/)?([\w]*)\].*$')
        end
      end

      context 'Gitlab' do
        it 'should read gitlab repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/gitlab_repositories.yml')
            configuration = config_reader.config

            expect(configuration.gitlab.repositories.size).to eql(2)
            expect(configuration.gitlab.repositories).to eql(['gitlab_username/my_repo_1', 'gitlab_username/my_repo_2'])
            expect(configuration.gitlab.access_token).to eql('Eu2ZVk8lL3P0YGw_aCFl')
            expect(configuration.gitlab.url).to eql('https://gitlab.com/api/v4')
            expect(configuration.gitlab.authors_regex).to eql('^.*\[([\w]*)(?:\/)?([\w]*)\].*$')
        end
      end
    end
end