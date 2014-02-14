function convertFilenames()

    baseName = '../131114/';

    for n = 1:20
        source = [baseName,'RL131114_4_',num2str(n),'.mat'];
        dest = [baseName,'RL131114_004_',num2str(n,'%03d'),'.mat'];
        movefile(source,dest);
    end
        