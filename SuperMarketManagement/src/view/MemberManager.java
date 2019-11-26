package com.nuota.view;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import java.util.List;
import java.util.Vector;

import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.naming.directory.SearchControls;
import javax.swing.JButton;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

import com.nuota.dao.ClassDao;
import com.nuota.model.StudentClass;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JTextArea;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class MemberManager extends JFrame {

	private JPanel contentPane;
	private JTextField searchTextField;
	private JTable MembersListTable;
	private JTextField editMemberNameTextField;
	private JTextArea editMemberInfoTextArea;
	private JTextField editPhoneTextField;
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MemberManager frame = new MemberManager();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public MemberManager() {
		setTitle("\u4F1A\u5458\u4FE1\u606F\u67E5\u8BE2&\u7BA1\u7406");
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 669, 555);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel label = new JLabel("\u4F1A\u5458\u540D\u79F0\uFF1A");
		label.setFont(new Font("微软雅黑", Font.PLAIN, 12));
		label.setBounds(132, 51, 72, 15);
		contentPane.add(label);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(98, 100, 459, 197);
		contentPane.add(scrollPane);
		
		MembersListTable = new JTable();
		MembersListTable.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent arg0) {
				selectedRow(arg0);
			}
		});
		MembersListTable.setModel(new DefaultTableModel(
			new Object[][] {
			},
			new String[] {
				"会员编号","会员名字", "联系电话", "备注信息"
			}
		) {
			boolean[] columnEditables = new boolean[] {
				false, false, false
			};
			public boolean isCellEditable(int row, int column) {
				return columnEditables[column];
			}
		});
		MembersListTable.getColumnModel().getColumn(3).setPreferredWidth(226);
		
		scrollPane.setViewportView(MembersListTable);
		
		searchTextField = new JTextField();
		searchTextField.setBounds(208, 48, 157, 21);
		contentPane.add(searchTextField);
		searchTextField.setColumns(10);
		
		JButton searchButton = new JButton("\u67E5\u8BE2");
//查询操作
//		searchButton.addActionListener(new ActionListener() {
//			public void actionPerformed(ActionEvent arg0) {
//				StudentMember serchText= new StudentMember();
//				serchText.setName(searchTextField.getText().toString());
//				setTable(serchText);
//			}
//		});
		searchButton.setBounds(401, 47, 77, 23);
		contentPane.add(searchButton);
		
		JLabel label_1 = new JLabel("\u4F1A\u5458\u540D\u79F0\uFF1A");
		label_1.setFont(new Font("微软雅黑", Font.PLAIN, 12));
		label_1.setBounds(38, 336, 72, 15);
		contentPane.add(label_1);
		
		editMemberNameTextField = new JTextField();
		editMemberNameTextField.setColumns(10);
		editMemberNameTextField.setBounds(98, 333, 130, 21);
		contentPane.add(editMemberNameTextField);
		
		JLabel label_2 = new JLabel("\u5907\u6CE8\u4FE1\u606F\uFF1A");
		label_2.setFont(new Font("微软雅黑", Font.PLAIN, 12));
		label_2.setBounds(38, 381, 72, 15);
		contentPane.add(label_2);
		
		editMemberInfoTextArea = new JTextArea();
		editMemberInfoTextArea.setLineWrap(true);
		editMemberInfoTextArea.setTabSize(2);
		editMemberInfoTextArea.setBounds(98, 377, 267, 119);
		contentPane.add(editMemberInfoTextArea);
		
		JButton submitEditButton = new JButton("\u786E\u8BA4\u4FEE\u6539");
		submitEditButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				submitEditAct(arg0);
			}
		});
		submitEditButton.setBounds(430, 402, 101, 23);
		contentPane.add(submitEditButton);
		
		JButton submitDeleteButton = new JButton("\u5220\u9664");
		submitDeleteButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//deleteMemberAct(e);
			}
		});
		submitDeleteButton.setBounds(430, 451, 101, 23);
		contentPane.add(submitDeleteButton);
		
		JLabel label_3 = new JLabel("\u8054\u7CFB\u7535\u8BDD\uFF1A");
		label_3.setFont(new Font("微软雅黑", Font.PLAIN, 12));
		label_3.setBounds(266, 336, 72, 15);
		contentPane.add(label_3);
		
		editPhoneTextField = new JTextField();
		editPhoneTextField.setColumns(10);
		editPhoneTextField.setBounds(332, 333, 130, 21);
		contentPane.add(editPhoneTextField);
		
		//初始化table
//		setTable(new StudentMember());
	}
	
	//	protected void deleteMemberAct(ActionEvent e) {
	//		// TODO Auto-generated method stub
	//		int index=MembersListTable.getSelectedRow();
	//		if(index==-1) {
	//			JOptionPane.showMessageDialog(this, "请选择要删除的对象！");
	//		}else {
	//			int choose=JOptionPane.showConfirmDialog(this, "     确定删除?", "提示", JOptionPane.OK_CANCEL_OPTION);
	//			if(choose!=JOptionPane.YES_OPTION) {				
	//				return;
	//			}
	//			//确认删除
	//			DefaultTableModel dftable=(DefaultTableModel) MembersListTable.getModel();
	//			int id=Integer.parseInt(dftable.getValueAt(MembersListTable.getSelectedRow(), 0).toString());
	//			MemberDao classDao=new MemberDao();
	//			if(classDao.delete(id)) {
	//				JOptionPane.showMessageDialog(this, "删除成功！");
	//				editMemberNameTextField.setText("");
	//				editMemberInfoTextArea.setText("");
	//				editPhoneTextArea.setText("");
	//			}else {
	//				JOptionPane.showMessageDialog(this, "删除失败！");
	//			}
	//			setTable(new StudentMember());//刷新列表
	//			classDao.closeDao();	
	//		}
	//		
	//	}

	protected void submitEditAct(ActionEvent arg0) {
		// TODO Auto-generated method stub
		
		
	}

	protected void selectedRow(MouseEvent arg0) {
		// TODO Auto-generated method stub
		DefaultTableModel dftable=(DefaultTableModel) MembersListTable.getModel();
		editMemberNameTextField.setText(dftable.getValueAt(MembersListTable.getSelectedRow(), 1).toString());
		editMemberInfoTextArea.setText(dftable.getValueAt(MembersListTable.getSelectedRow(), 2).toString());
		
	}

//	private void setTable(StudentMember serchText) {
//		DefaultTableModel dftable=(DefaultTableModel) MembersListTable.getModel();
//		dftable.setRowCount(0);
//		MemberDao classDao=new MemberDao();
//		List<StudentMember> classList = classDao.getMemberList(serchText);
//		for(StudentMember sc:classList) {
//			Vector v=new Vector();//类似于list的数据结构
//			v.add(sc.getId());	//第一列添加
//			v.add(sc.getName());	//第二列添加
//			v.add(sc.getInfo());
//			dftable.addRow(v);		//添加一行
//		}
//		classDao.closeDao();
//	}
}
