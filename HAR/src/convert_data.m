function XSub = convert_data(subFolder, split)

    bx = readmatrix(fullfile(subFolder, "body_acc_x_" + split + ".txt"));
    by = readmatrix(fullfile(subFolder, "body_acc_y_" + split + ".txt"));
    bz = readmatrix(fullfile(subFolder, "body_acc_z_" + split + ".txt"));

    gx = readmatrix(fullfile(subFolder, "body_gyro_x_" + split + ".txt"));
    gy = readmatrix(fullfile(subFolder, "body_gyro_y_" + split + ".txt"));
    gz = readmatrix(fullfile(subFolder, "body_gyro_z_" + split + ".txt"));

    tx = readmatrix(fullfile(subFolder, "total_acc_x_" + split + ".txt"));
    ty = readmatrix(fullfile(subFolder, "total_acc_y_" + split + ".txt"));
    tz = readmatrix(fullfile(subFolder, "total_acc_z_" + split + ".txt"));

    num = size(bx,1);
    XSub = cell(num,1);

    for i = 1:num
        XSub{i} = [bx(i,:); by(i,:); bz(i,:);
                   gx(i,:); gy(i,:); gz(i,:);
                   tx(i,:); ty(i,:); tz(i,:)];
    end
end