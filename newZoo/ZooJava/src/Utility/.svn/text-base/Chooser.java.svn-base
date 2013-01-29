//        JButton button = new JButton("MOCK FILE CHOOSER");
//        add(button, BorderLayout.SOUTH);
//        button.addActionListener(new ActionListener() {
//            @Override
//            public void actionPerformed(ActionEvent ae) {
//                JFileChooser chooser = new JFileChooser();
//                int val = chooser.showOpenDialog(chooser);
//                if (val == JFileChooser.APPROVE_OPTION) {
//                    File file = chooser.getSelectedFile();
//
//
//                    if (file.getPath().endsWith(".jpg") || file.getPath().endsWith(".JPG")) {
//                        System.out.println(file);
//                        String filePath = file.getPath();
//                        filePath = filePath.replace('\\', '/');
//                        System.out.println(filePath);
//                        String[] bits = filePath.split("/");
//                        String filename = bits[bits.length - 1];
//                        System.out.println(filename);
//                        File newFile = new File(filename);
//                        System.out.println(newFile.getPath());
//                        try {
//                            newFile.createNewFile();
//                        } catch (IOException ex) {
//                            System.out.println(ex);
//                        }
//                        try {
//                            FileOutputStream out;
//                            try (FileInputStream in = new FileInputStream(file)) {
//                                out = new FileOutputStream(newFile);
//                                byte[] buf = new byte[1024];
//                                int len;
//                                while ((len = in.read(buf)) > 0) {
//                                    out.write(buf, 0, len);
//                                }
//                            }
//                            out.close();
//                        } catch (IOException ex) {
//                            System.out.println(ex);
//                        }
//                    }
//                }
//            }
//        });